Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2EE3A37F6
	for <lists+linux-fpga@lfdr.de>; Fri, 11 Jun 2021 01:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFJXi7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 10 Jun 2021 19:38:59 -0400
Received: from mail-bn7nam10on2081.outbound.protection.outlook.com ([40.107.92.81]:34884
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229578AbhFJXi6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 10 Jun 2021 19:38:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vj3XwlK01PW6hXqM3uQm0HniUNqi52iOE9XxWPe9QjIwbdlBB5MQov4MGfpjDZiP5jeutvXrJ0o1gTutJaS0/Kbw6lFTNTw0WaKZvaEwuYUm1Yh5eUARc7z5CYaMbSIluZEG7vtJ0DqN5Vxb8lQxKBBgkdFzGdwLeD9MfXfUoLEaR0XqjD867IZEKCJXrzas6nlyteJlY0fWoU5z5aP5lvkD/h3Gh5YYbnIs1gRvgVVgyTPwv2s07HxuXNOAw+jKS8pzaIhOHw2zhNkzHpuQ1J5IgLwbQVnTpLRnVESuP0iXQj1HTHmLrXE2wAqKHqaYNDIWYufqC3DOimCWgSNvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm7kpb6AeKcDS+Kb4asJw505/wetF/D7MnleEN6B890=;
 b=XRaqwNMNHwqc2C2bbMSn7zT4M1MO9SETG8lucLhrihO11mtJabpShN5n1yyM+CA5IZvzp6YVjKPhJlbpU6Z3jaqA1PK7ACWoGm3B2GmkrTmTCSzbWOdB7WavsHvbzQZzihtRusnVvsI0YSr/v1WjJyvikG2mZ2JRpEbeODoLQd3DBAjNH6c/588YJhJuiHgRHkYQbGf0X/rhSL7P1opROkKZzcO+c/7Zy4uWYmyBlZ90jur7NMcx0V783FYz7JxSGPoIuuUgxtV5ywpJlXHTNYjCAuvTIaIxyv8scODSaD0A8RUYY7jh5D+gKqoAFePHoYYCTdBqbEW5V2P/TEvezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jm7kpb6AeKcDS+Kb4asJw505/wetF/D7MnleEN6B890=;
 b=AlsbZE2YWKbRRuEyDzhJKJXMvCa6vYg+/CQ1uMPfrZgPje0Cv4Urhhdo5rKS1AxoHcej3WUKzCHgN5ew5pQMCQrFT/8bJ35ic2cw6gij8Bq0bvA53BaEyJvuq3PD8muI+UprL//nqsVBPKALbP6uV8XXkgRc4i4eJksuEfFLbp0=
Received: from DM6PR11CA0068.namprd11.prod.outlook.com (2603:10b6:5:14c::45)
 by BYAPR02MB5016.namprd02.prod.outlook.com (2603:10b6:a03:69::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23; Thu, 10 Jun
 2021 23:36:57 +0000
Received: from DM3NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::a5) by DM6PR11CA0068.outlook.office365.com
 (2603:10b6:5:14c::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 23:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT060.mail.protection.outlook.com (10.13.4.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4219.21 via Frontend Transport; Thu, 10 Jun 2021 23:36:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 10 Jun 2021 16:36:55 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 10 Jun 2021 16:36:55 -0700
Envelope-to: robh@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 mdf@kernel.org,
 hao.wu@intel.com,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=50930)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lrUEJ-0003to-OF; Thu, 10 Jun 2021 16:36:55 -0700
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Subject: Re: RFC : [PATCH V7 XRT Alveo 00/20] XRT Alveo driver overview
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>, "Wu, Hao" <hao.wu@intel.com>,
        "mdf@kernel.org" <mdf@kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <robh@kernel.org>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
 <bdd31ecc-f6c5-392b-1609-f05efcba7f88@xilinx.com>
 <68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com>
Message-ID: <8cffb27e-88c1-cbea-24cd-aae03aad4e2d@xilinx.com>
Date:   Thu, 10 Jun 2021 16:36:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08ac196f-4b1f-4f7b-858f-08d92c68a2f1
X-MS-TrafficTypeDiagnostic: BYAPR02MB5016:
X-Microsoft-Antispam-PRVS: <BYAPR02MB50164BEAABC61F2DD962D9B9A1359@BYAPR02MB5016.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKUTWqCCSTwCH4Qptw4Cfts8KwvoFp07YyIhddXfbvvAunJjhOm9NEId3YQd/f7ndzkb2H2tMPMZBDOjz5lRdv74yXD9oLh9h7H4qjo5OCIfyCJBe6neIEhLoVlMKF5iHfa2rXUwPQiFEmUJEre5wHgCJo5ZRL7DAciIwE31KeVdiN7YDZPOhCEuQYO1qy/tldKedcrWG2ix0aFKN1fxY2wp7vWKdFNHj/KFo/MnQDhVOCL0mY55/vvSWyrY9FVLqUxRb0nGnXwU3+hMZOTG8zm19y79jUCEuaOHBPGzf07/EU3iSPyubwYVx4oVsla54/DTt9yDqtq+sOeGNoaCk3U/T28JeYlozTEf3IblCV+dyXd8FnWLJ9EGDP8eD1SvtfZ5AEaDMr5XSYjZi2wdRqfFELsPYx5kzENVaiwRIMtbhQ/h32cwaDiwv8VXrC+JOg2wpWkn0GQek33k+JyeyfJgY7zMHtBTBDoBcUcuOWgddGGP3ttwvpCko8TY77iplfK2dvFRLba0lYwYAeH83z0MTqtGO5iVOJldkX0VZp08Ykv8pFIDcZeBfVjnTZGw9EJ89EGUBME/k9vmlKAdei43ORUnIU+pRxzN/wdMydjHmdEfWDmbsbAqBwtBYytbevwLxahoBi6sDzAbUlNk9T2weOAuw1L1IuT2zMyOT2qNNF43oD017S7lyAuZyuksf8kFu0IN2YO/d0Yc8JIc/DeSXsOQRoBQdxKbhuX0Rb2XcnmmVRI9RqSplMP/ljZWIvtw7CGLo6sFyeHpM07FUCrZQzNPLndQ3L+z0/xCLsQ1sdkgNRPkeVlq6Oig/IxCGtMAvej1ng/MRK2u1fZZcoY9vD3ccYhFXuqPCofxiZV/v7mpP2KhdysA2yjUJ4Vd
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(346002)(136003)(46966006)(36840700001)(2616005)(70586007)(966005)(8676002)(2906002)(4326008)(82310400003)(36906005)(44832011)(70206006)(186003)(53546011)(31686004)(8936002)(7636003)(36860700001)(316002)(26005)(36756003)(31696002)(336012)(54906003)(478600001)(5660300002)(426003)(110136005)(9786002)(82740400003)(47076005)(356005)(30864003)(83380400001)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 23:36:57.0694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ac196f-4b1f-4f7b-858f-08d92c68a2f1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5016
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 06/03/2021 07:23 AM, Tom Rix wrote:
>
>
> On 6/2/21 3:34 PM, Lizhi Hou wrote:
>> Hi Moritz and Tom,
>>
>> Thanks a lot for reviewing the XRT patches. This v7 patches contains
>> our latest fixes for all review comments. And it seems auto build
>> robot is happy with it as well. Do you have more comment against v7?
>> What will be the next step for XRT patches if it looks ok to you?
>
> Please do not add any features to the patchset.
>
> When you add a feature, that tends to reset the review process.
>
>
> For little stuff.
>
> I need to look at the documentation again, iirc that was the only issue
> in v6.
>
>
> For big stuff.
>
> At the beginning some possible refactor questions were raised, I don't
> know if they have been resolved.
>
> ex/
>
> some of the leaf drivers like clock should be moved the clock subsystem
>
> the xrt/ dir vs existing flat, we don't want both.
>
> is your xrt bus consistent with dfl bus, can it support adding devices
> outside of fpga/xrt
It would be ideal if we make incremental changes to move xrt xleaf 
drivers to other subsystems. One question comes to mind if xleaf drivers 
move to different subsystems they would need to become independent ko. 
That would require load/unload dependency management complicating the 
design. Also if we go in that direction xdevice.h should move to 
linux/include?
>
> how clean are the public headers
Is there anything in the public header we need to change?
>
>
> Since flipflopping on refactoring is a painful, let's try to get a
> consensus before moving forward.
>
> This may mean the patchset is committed by parts as it and the existing
> code changes.
>
>
> Lets start with the directory structure.
>
> Since there are a lot of files in xrt, the xrt/ makes sense.
>
> For other fpga's with a lot of files, say > 3, we need to change ex/
>
> dfl-foo.c to dfl/foo.c
>
> to be consistent.
>
>
> The Kconfig and Makefiles for xrt/ and dfl/ would only be in that top
> subdir.
>
> Which i think is a change for xrt/
>
>
> I'll whip up something for dfl/ to move things along.
We will wait for the new structure of dfl/ and make necessary for xrt/ 
accordingly.

Thanks,
Lizhi
>
> Tom
>
>
>>
>> Thanks,
>>
>> Lizhi
>>
>>
>> On 05/27/2021 05:49 PM, Lizhi Hou wrote:
>>> Hello,
>>>
>>> This is V7 of patch series which adds management physical function
>>> driver
>>> for Xilinx Alveo PCIe accelerator cards.
>>> https://www.xilinx.com/products/boards-and-kits/alveo.html
>>>
>>> This driver is part of Xilinx Runtime (XRT) open source stack.
>>>
>>> XILINX ALVEO PLATFORM ARCHITECTURE
>>>
>>> Alveo PCIe FPGA based platforms have a static *shell* partition and a
>>> partial re-configurable *user* partition. The shell partition is
>>> automatically loaded from flash when host is booted and PCIe is
>>> enumerated
>>> by BIOS. Shell cannot be changed till the next cold reboot. The shell
>>> exposes two PCIe physical functions:
>>>
>>> 1. management physical function
>>> 2. user physical function
>>>
>>> The patch series includes Documentation/xrt.rst which describes Alveo
>>> platform, XRT driver architecture and deployment model in more detail.
>>>
>>> Users compile their high level design in C/C++/OpenCL or RTL into FPGA
>>> image using Vitis tools.
>>> https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
>>>
>>> The compiled image is packaged as xclbin which contains partial
>>> bitstream
>>> for the user partition and necessary metadata. Users can dynamically
>>> swap
>>> the image running on the user partition in order to switch between
>>> different workloads by loading different xclbins.
>>>
>>> XRT DRIVERS FOR XILINX ALVEO
>>>
>>> XRT Linux kernel driver *xrt-mgmt* binds to management physical
>>> function of
>>> Alveo platform. The modular driver framework is organized into several
>>> platform drivers which primarily handle the following functionality:
>>>
>>> 1.  Loading firmware container also called xsabin at driver attach time
>>> 2.  Loading of user compiled xclbin with FPGA Manager integration
>>> 3.  Clock scaling of image running on user partition
>>> 4.  In-band sensors: temp, voltage, power, etc.
>>> 5.  Device reset and rescan
>>>
>>> The platform drivers are packaged into *xrt-lib* helper module with 
>>> well
>>> defined interfaces. The module provides a pseudo-bus implementation
>>> for the
>>> platform drivers. More details on the driver model can be found in
>>> Documentation/xrt.rst.
>>>
>>> User physical function driver is not included in this patch series.
>>>
>>> LIBFDT REQUIREMENT
>>>
>>> XRT driver infrastructure uses Device Tree as a metadata format to
>>> discover
>>> HW subsystems in the Alveo PCIe device. The Device Tree schema used
>>> by XRT
>>> is documented in Documentation/xrt.rst.
>>>
>>> TESTING AND VALIDATION
>>>
>>> xrt-mgmt driver can be tested with full XRT open source stack which
>>> includes user space libraries, board utilities and (out of tree) first
>>> generation user physical function driver xocl. XRT open source runtime
>>> stack is available at https://github.com/Xilinx/XRT
>>>
>>> Complete documentation for XRT open source stack including sections on
>>> Alveo/XRT security and platform architecture can be found here:
>>>
>>> https://xilinx.github.io/XRT/master/html/index.html
>>> https://xilinx.github.io/XRT/master/html/security.html
>>> https://xilinx.github.io/XRT/master/html/platforms_partitions.html
>>>
>>> Changes since v6:
>>> - Resolved grammatical errors and cleaned up taxonomy in xrt.rst
>>>    documentation.
>>> - Fixed clang warnings.
>>> - Updated code base to include v6 code review comments.
>>>
>>> Changes since v5:
>>> - Revert all changes 'mgnt/MGNT' back to 'mgmt/MGMT'
>>> - Updated code base to include v5 code review comments.
>>>     xrt.rst: address grammar and taxonomy
>>>     subdev_id.h: defines XRT_SUBDEV_INVALID = 0
>>>     xclbin.c: change shift operation to be_to_cpu
>>> - Resolved kernel test robot errors.
>>>
>>> Changes since v4:
>>> - Added xrt_bus_type and xrt_device. All sub devices were changed from
>>>    platform_bus_type/platform_device to xrt_bus_type/xrt_device.
>>> - Renamed xrt-mgmt driver to xrt-mgnt driver.
>>> - Replaced 'MGMT' with 'MGNT' and 'mgmt' with 'mgnt' in code and file
>>> names
>>> - Moved pci function calls from infrastructure to xrt-mgnt driver.
>>> - Renamed files: mgmt/main.c -> mgnt/xmgnt-main.c
>>>                   mgmt/main-region.c -> mgnt/xmgnt-main-region.c
>>>                   include/xmgmt-main.h -> include/xmgnt-main.h
>>>                   mgmt/fmgr-drv.c -> mgnt/xrt-mgr.c
>>>                   mgmt/fmgr.h -> mgnt/xrt-mgr.h
>>> - Updated code base to include v4 code review comments.
>>>
>>> Changes since v3:
>>> - Leaf drivers use regmap-mmio to access hardware registers.
>>> - Renamed driver module: xmgmt.ko -> xrt-mgmt.ko
>>> - Renamed files: calib.[c|h] -> ddr_calibration.[c|h],
>>>                   lib/main.[c|h] -> lib/lib-drv.[c|h],
>>>                   mgmt/main-impl.h - > mgmt/xmgnt.h
>>> - Updated code base to include v3 code review comments.
>>>
>>> Changes since v2:
>>> - Streamlined the driver framework into *xleaf*, *group* and *xroot*
>>> - Updated documentation to show the driver model with examples
>>> - Addressed kernel test robot errors
>>> - Added a selftest for basic driver framework
>>> - Documented device tree schema
>>> - Removed need to export libfdt symbols
>>>
>>> Changes since v1:
>>> - Updated the driver to use fpga_region and fpga_bridge for FPGA
>>>    programming
>>> - Dropped platform drivers not related to PR programming to focus on 
>>> XRT
>>>    core framework
>>> - Updated Documentation/fpga/xrt.rst with information on XRT core
>>> framework
>>> - Addressed checkpatch issues
>>> - Dropped xrt- prefix from some header files
>>>
>>> For reference V6 version of patch series can be found here:
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-1-lizhi.hou@xilinx.com/ 
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-2-lizhi.hou@xilinx.com/ 
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-3-lizhi.hou@xilinx.com/ 
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-4-lizhi.hou@xilinx.com/ 
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-5-lizhi.hou@xilinx.com/ 
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-6-lizhi.hou@xilinx.com/ 
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-7-lizhi.hou@xilinx.com/ 
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-8-lizhi.hou@xilinx.com/ 
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-9-lizhi.hou@xilinx.com/ 
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-10-lizhi.hou@xilinx.com/ 
>>>
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-11-lizhi.hou@xilinx.com/ 
>>>
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-12-lizhi.hou@xilinx.com/ 
>>>
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-13-lizhi.hou@xilinx.com/ 
>>>
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-14-lizhi.hou@xilinx.com/ 
>>>
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-15-lizhi.hou@xilinx.com/ 
>>>
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-16-lizhi.hou@xilinx.com/ 
>>>
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-17-lizhi.hou@xilinx.com/ 
>>>
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-18-lizhi.hou@xilinx.com/ 
>>>
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-19-lizhi.hou@xilinx.com/ 
>>>
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-20-lizhi.hou@xilinx.com/ 
>>>
>>>
>>> https://lore.kernel.org/lkml/20210512015339.5649-21-lizhi.hou@xilinx.com/ 
>>>
>>>
>>>
>>> Lizhi Hou (20):
>>>    Documentation: fpga: Add a document describing XRT Alveo drivers
>>>    fpga: xrt: driver metadata helper functions
>>>    fpga: xrt: xclbin file helper functions
>>>    fpga: xrt: xrt-lib driver manager
>>>    fpga: xrt: group driver
>>>    fpga: xrt: char dev node helper functions
>>>    fpga: xrt: root driver infrastructure
>>>    fpga: xrt: driver infrastructure
>>>    fpga: xrt: management physical function driver (root)
>>>    fpga: xrt: main driver for management function device
>>>    fpga: xrt: fpga-mgr and region implementation for xclbin download
>>>    fpga: xrt: VSEC driver
>>>    fpga: xrt: User Clock Subsystem driver
>>>    fpga: xrt: ICAP driver
>>>    fpga: xrt: devctl xrt driver
>>>    fpga: xrt: clock driver
>>>    fpga: xrt: clock frequency counter driver
>>>    fpga: xrt: DDR calibration driver
>>>    fpga: xrt: partition isolation driver
>>>    fpga: xrt: Kconfig and Makefile updates for XRT drivers
>>>
>>>   Documentation/fpga/index.rst                  |   1 +
>>>   Documentation/fpga/xrt.rst                    | 870 
>>> ++++++++++++++++++
>>>   MAINTAINERS                                   |  11 +
>>>   drivers/Makefile                              |   1 +
>>>   drivers/fpga/Kconfig                          |   2 +
>>>   drivers/fpga/Makefile                         |   5 +
>>>   drivers/fpga/xrt/Kconfig                      |   8 +
>>>   drivers/fpga/xrt/include/events.h             |  45 +
>>>   drivers/fpga/xrt/include/group.h              |  25 +
>>>   drivers/fpga/xrt/include/metadata.h           | 236 +++++
>>>   drivers/fpga/xrt/include/subdev_id.h          |  39 +
>>>   drivers/fpga/xrt/include/xclbin-helper.h      |  48 +
>>>   drivers/fpga/xrt/include/xdevice.h            | 131 +++
>>>   drivers/fpga/xrt/include/xleaf.h              | 205 +++++
>>>   drivers/fpga/xrt/include/xleaf/axigate.h      |  23 +
>>>   drivers/fpga/xrt/include/xleaf/clkfreq.h      |  21 +
>>>   drivers/fpga/xrt/include/xleaf/clock.h        |  29 +
>>>   .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +
>>>   drivers/fpga/xrt/include/xleaf/devctl.h       |  40 +
>>>   drivers/fpga/xrt/include/xleaf/icap.h         |  27 +
>>>   drivers/fpga/xrt/include/xmgmt-main.h         |  34 +
>>>   drivers/fpga/xrt/include/xroot.h              | 117 +++
>>>   drivers/fpga/xrt/lib/Kconfig                  |  17 +
>>>   drivers/fpga/xrt/lib/Makefile                 |  30 +
>>>   drivers/fpga/xrt/lib/cdev.c                   | 209 +++++
>>>   drivers/fpga/xrt/lib/group.c                  | 278 ++++++
>>>   drivers/fpga/xrt/lib/lib-drv.c                | 328 +++++++
>>>   drivers/fpga/xrt/lib/lib-drv.h                |  21 +
>>>   drivers/fpga/xrt/lib/subdev.c                 | 859 +++++++++++++++++
>>>   drivers/fpga/xrt/lib/subdev_pool.h            |  53 ++
>>>   drivers/fpga/xrt/lib/xclbin.c                 | 381 ++++++++
>>>   drivers/fpga/xrt/lib/xleaf/axigate.c          | 325 +++++++
>>>   drivers/fpga/xrt/lib/xleaf/clkfreq.c          | 223 +++++
>>>   drivers/fpga/xrt/lib/xleaf/clock.c            | 652 +++++++++++++
>>>   drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 210 +++++
>>>   drivers/fpga/xrt/lib/xleaf/devctl.c           | 169 ++++
>>>   drivers/fpga/xrt/lib/xleaf/icap.c             | 328 +++++++
>>>   drivers/fpga/xrt/lib/xleaf/ucs.c              | 152 +++
>>>   drivers/fpga/xrt/lib/xleaf/vsec.c             | 372 ++++++++
>>>   drivers/fpga/xrt/lib/xroot.c                  | 536 +++++++++++
>>>   drivers/fpga/xrt/metadata/Kconfig             |  12 +
>>>   drivers/fpga/xrt/metadata/Makefile            |  16 +
>>>   drivers/fpga/xrt/metadata/metadata.c          | 578 ++++++++++++
>>>   drivers/fpga/xrt/mgmt/Kconfig                 |  15 +
>>>   drivers/fpga/xrt/mgmt/Makefile                |  19 +
>>>   drivers/fpga/xrt/mgmt/root.c                  | 420 +++++++++
>>>   drivers/fpga/xrt/mgmt/xmgmt-main-region.c     | 483 ++++++++++
>>>   drivers/fpga/xrt/mgmt/xmgmt-main.c            | 662 +++++++++++++
>>>   drivers/fpga/xrt/mgmt/xmgmt.h                 |  33 +
>>>   drivers/fpga/xrt/mgmt/xrt-mgr.c               | 190 ++++
>>>   drivers/fpga/xrt/mgmt/xrt-mgr.h               |  16 +
>>>   include/uapi/linux/xrt/xclbin.h               | 409 ++++++++
>>>   include/uapi/linux/xrt/xmgmt-ioctl.h          |  46 +
>>>   53 files changed, 9988 insertions(+)
>>>   create mode 100644 Documentation/fpga/xrt.rst
>>>   create mode 100644 drivers/fpga/xrt/Kconfig
>>>   create mode 100644 drivers/fpga/xrt/include/events.h
>>>   create mode 100644 drivers/fpga/xrt/include/group.h
>>>   create mode 100644 drivers/fpga/xrt/include/metadata.h
>>>   create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>>>   create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
>>>   create mode 100644 drivers/fpga/xrt/include/xdevice.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>>>   create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>>>   create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
>>>   create mode 100644 drivers/fpga/xrt/include/xroot.h
>>>   create mode 100644 drivers/fpga/xrt/lib/Kconfig
>>>   create mode 100644 drivers/fpga/xrt/lib/Makefile
>>>   create mode 100644 drivers/fpga/xrt/lib/cdev.c
>>>   create mode 100644 drivers/fpga/xrt/lib/group.c
>>>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
>>>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
>>>   create mode 100644 drivers/fpga/xrt/lib/subdev.c
>>>   create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
>>>   create mode 100644 drivers/fpga/xrt/lib/xclbin.c
>>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
>>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
>>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c
>>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
>>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>>>   create mode 100644 drivers/fpga/xrt/lib/xroot.c
>>>   create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>>>   create mode 100644 drivers/fpga/xrt/metadata/Makefile
>>>   create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>>>   create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>>>   create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>>>   create mode 100644 drivers/fpga/xrt/mgmt/root.c
>>>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main-region.c
>>>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main.c
>>>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt.h
>>>   create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.c
>>>   create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.h
>>>   create mode 100644 include/uapi/linux/xrt/xclbin.h
>>>   create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h
>>>
>>
>

