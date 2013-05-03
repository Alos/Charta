/*
 * Jakefile
 * Charta
 *
 * Created by Alos on May 1, 2013.
 * Copyright 2013, Your Company All rights reserved.
 */

var ENV = require("system").env,
    FILE = require("file"),
    JAKE = require("jake"),
    task = JAKE.task,
    FileList = JAKE.FileList,
    app = require("cappuccino/jake").app,
    configuration = ENV["CONFIG"] || ENV["CONFIGURATION"] || ENV["c"] || "Debug",
    OS = require("os");

app ("Charta", function(task)
{
    ENV["OBJJ_INCLUDE_PATHS"] = "Frameworks/Debug:Frameworks";
    task.setBuildIntermediatesPath(FILE.join("Build", "Charta.build", configuration));
    task.setBuildPath(FILE.join("Build", configuration));

    task.setProductName("Charta");
    task.setIdentifier("com.alosinc.");
    task.setVersion("1.0");
    task.setAuthor("Alos Inc");
    task.setEmail("feedback @alosii@ gmail.com");
    task.setSummary("Charta");
    task.setSources((new FileList("**/*.j")).exclude(FILE.join("Build", "**")));
    task.setResources(new FileList("Resources/**"));
    task.setIndexFilePath("index.html");
    task.setInfoPlistPath("Info.plist");

    if (configuration === "Debug")
        task.setCompilerFlags("-DDEBUG -g");
    else
        task.setCompilerFlags("-O");
});

task ("default", ["Charta"], function()
{
    printResults(configuration);
});

task ("build", ["default"]);

task ("debug", function()
{
    ENV["CONFIGURATION"] = "Debug";
    JAKE.subjake(["."], "build", ENV);
});

task ("release", function()
{
    ENV["CONFIGURATION"] = "Release";
    JAKE.subjake(["."], "build", ENV);
});

task ("run", ["debug"], function()
{
    OS.system(["open", FILE.join("Build", "Debug", "Charta", "index.html")]);
});

task ("run-release", ["release"], function()
{
    OS.system(["open", FILE.join("Build", "Release", "Charta", "index.html")]);
});

task ("deploy", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Deployment", "Charta"));
    OS.system(["press", "-f", FILE.join("Build", "Release", "Charta"), FILE.join("Build", "Deployment", "Charta")]);
    printResults("Deployment")
});

task ("desktop", ["release"], function()
{
    FILE.mkdirs(FILE.join("Build", "Desktop", "Charta"));
    require("cappuccino/nativehost").buildNativeHost(FILE.join("Build", "Release", "Charta"), FILE.join("Build", "Desktop", "Charta", "Charta.app"));
    printResults("Desktop")
});

task ("run-desktop", ["desktop"], function()
{
    OS.system([FILE.join("Build", "Desktop", "Charta", "Charta.app", "Contents", "MacOS", "NativeHost"), "-i"]);
});

function printResults(configuration)
{
    print("----------------------------");
    print(configuration+" app built at path: "+FILE.join("Build", configuration, "Charta"));
    print("----------------------------");
}
