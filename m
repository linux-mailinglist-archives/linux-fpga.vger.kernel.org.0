Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7B546C3A0
	for <lists+linux-fpga@lfdr.de>; Tue,  7 Dec 2021 20:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhLGTdH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 Dec 2021 14:33:07 -0500
Received: from mail-co1nam11on2046.outbound.protection.outlook.com ([40.107.220.46]:10208
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231811AbhLGTdH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 7 Dec 2021 14:33:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbXGWkyoCt3WZxSa9HXAuCzQTRF92f68e+0yRY+Rr1XUBRVEIU680RPH+ibtuRdXonp/AYjvJDLoGtRUZQPTqOAY8I/20SOdduCzN+Wj1IY4fTAXG+L3Ky+02RkkCGSgDLPmkwkM6OnDFNTBQF5ZwUao1QItZOHLB+EsomJLKP1FtxxcspiQ3h5J7hqDo8e9lWztcZ5nRSfgt4vZ0BGQ3KomJLi150fitQgZHShwLcLZt5tWEatJSSw6rfg9GwmKo7a5GkN6HImY4dmQyiXyW+5iR0MlzbjuPaKBGlkganx3PjFEu5JZBP4NjOt6uh6Gbi1rx1PbbvQACebFERqKmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPzQ+Ua/d0rZ6HUxWtv973T7YQqw3U0fmelJh8TpA/8=;
 b=M6v492U7m7lAmWYsDupF7wH3++s5ZrBk7QoyLnLqWIl/fXJowGQfDZ1YcX+XPocEI8+5rgCGH6GdtB4yR5QbaTu4vXi4mL7HsVCVMUS7SUHOV4YOyDR6KlwMH9OWgTZSefbLVd25r8HzFAKaAB5AjCfae0QypgzfXSTiNDdjvumopKtFHaHk+p91kHEtnTAQc+dHiVHxO5yjPyw7kas+r8/KpDfvlsUqR4s8WMqj7Ql96Ow2iCUHpTXkBaChY22R3hxuLzL/qmas19GAqXaKLMgVeS+rQggGPkC21Df+uvdp+X50yJgJyCo+C2nCt8EiMW56sgGlJoD8aYSe6gP90A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPzQ+Ua/d0rZ6HUxWtv973T7YQqw3U0fmelJh8TpA/8=;
 b=Aj5O73pX5I7ote2KSBaEqXwPEp0+azRSBRjLsZdaNd1dDhiYUMexq/rx26DU05KhNT+TeTesW7NT6PjT9rlgj5tmGHLW1KonnYoOw/EsbDssGgAg2kIojFC0+bEGUZ/rWt1IspIPxzH4g7TTX9NOwMlMNI7lk4Rqucs6h9kmD4Y=
Received: from DM5PR11CA0006.namprd11.prod.outlook.com (2603:10b6:3:115::16)
 by BYAPR02MB5640.namprd02.prod.outlook.com (2603:10b6:a03:9c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Tue, 7 Dec
 2021 19:29:33 +0000
Received: from DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::7e) by DM5PR11CA0006.outlook.office365.com
 (2603:10b6:3:115::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Tue, 7 Dec 2021 19:29:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT059.mail.protection.outlook.com (10.13.4.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Tue, 7 Dec 2021 19:29:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 7 Dec 2021 11:29:31 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 7 Dec 2021 11:29:31 -0800
Envelope-to: dwmw2@infradead.org,
 robh@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 yilun.xu@intel.com
Received: from [10.17.2.60] (port=49866)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mug9b-0005CR-SY; Tue, 07 Dec 2021 11:29:31 -0800
Subject: Re: [PATCH V2 XRT Alveo Infrastructure 1/9] Documentation: fpga: Add
 a document describing XRT Alveo driver infrastructure
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     Xu Yilun <yilun.xu@intel.com>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
 <20211119222412.1092763-2-lizhi.hou@xilinx.com>
 <20211202070438.GB336280@yilunxu-OptiPlex-7050>
 <cafdb152-f219-5e01-7cec-ccb82f5a1b84@xilinx.com>
Message-ID: <4367aa73-114d-e830-a31c-93701315f0d9@xilinx.com>
Date:   Tue, 7 Dec 2021 11:29:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <cafdb152-f219-5e01-7cec-ccb82f5a1b84@xilinx.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aef2cd39-1113-42c5-0785-08d9b9b7e51e
X-MS-TrafficTypeDiagnostic: BYAPR02MB5640:EE_
X-Microsoft-Antispam-PRVS: <BYAPR02MB5640AE31864FA1910C09A20CA16E9@BYAPR02MB5640.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dyTJY+mbgUjpdsv82OIYB7a5T6gwFkfvnchPLj8l10Caj5HqDbKcAOdV8FFN3VTZNfaie3sSQZmWjV0foaO8PGHAXHrtBnbcMQvOz48nUUd8kkhkuyrur42rXrC9Qa5QDfI4Gzj1F1z05lsoq/EJkZDwR55x5DoJgq/C52hwcMuosDWQ5LQHnk7bF15hR2H73RPdZflDQ8YkTrfVsVKdmyfm+4ZYLvQvLcwcerZx/ho72eOtJHwkOp0e0uFhWR+Q01kirS/Ni2lhl3bXvB8Zxk43PnizIoeKybK5AlhACF33K5Qk1psETwJ9+8fI2DX5uaMtXzirzgIXqQgkquOgqnCr1XLuWL4EL6fGSU5e880eYf4U8craHrUjzNdvpbSW/6XyjgoM1z11aHpwarJPeg1hWZNIAwP/huBGSwhIXUosmBRto1KzJK2yYR0TgN4PP7p3K7P1xWkKkVyzMAQTASTQLUciuX7kjMBfHBNw6cgO0wPUHFR2TCZqo0/fiS2C36qWo0qbP50/JKhQxZoXKvVfpCKWTt5i0rfVJez/A69ioszIkh2iGduOeDCrwroZLDUSCbCOiBWO5lYSNZnAy8cpZtQgbOt3EsGqVEOHTxn1srX7T9ofcUjdIE8FEpMguyWhR24n1kbLnAnIpaPdUR3xIk6FIaggOH/2xzNaxDOl/O/Vg78DSiy3TddRzXjbKl3jJZZuewuBLsfeD3UZJYvw/rTW54PYbAWQdfJk127PSTRXkN9Y8dnyAXUHHlbOwn2dhkYkHzAUCpObr3yuf+6OXOyk1Xs7D4sNQutPP2wqStxpcPNTD6CQS8lsRM27QudIXYQEIGZppfeTKRdwoHLchB3Rf5Zq0ikynpGuEPV21QRPTZjf3yYwTUjdhgoH
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(356005)(26005)(45080400002)(7636003)(336012)(186003)(47076005)(966005)(30864003)(54906003)(70586007)(316002)(70206006)(508600001)(2616005)(2906002)(110136005)(36860700001)(31696002)(107886003)(8676002)(44832011)(83380400001)(8936002)(31686004)(82310400004)(5660300002)(426003)(4326008)(36756003)(9786002)(53546011)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 19:29:32.2802
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aef2cd39-1113-42c5-0785-08d9b9b7e51e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5640
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,

We had discussed this internally. And I add my comments in line.

On 12/3/21 4:33 PM, Lizhi Hou wrote:
> Hi Yilun,
>
> Thanks a lot for your feedback. They all seem generic questions. We 
> will discuss them internally and get back to you soon.
>
> In the meanwhile, I am going to send out another patch set for Rob's 
> comments.
>
>
> Thanks,
>
> Lizhi
>
> On 12/1/21 11:04 PM, Xu Yilun wrote:
>>
>> On Fri, Nov 19, 2021 at 02:24:04PM -0800, Lizhi Hou wrote:
>>> Describe XRT driver architecture and provide basic overview of
>>> Xilinx Alveo platform.
>>>
>>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>>> ---
>>>   Documentation/fpga/index.rst |   1 +
>>>   Documentation/fpga/xrt.rst   | 510 
>>> +++++++++++++++++++++++++++++++++++
>>>   MAINTAINERS                  |  10 +
>>>   3 files changed, 521 insertions(+)
>>>   create mode 100644 Documentation/fpga/xrt.rst
>>>
>>> diff --git a/Documentation/fpga/index.rst 
>>> b/Documentation/fpga/index.rst
>>> index f80f95667ca2..30134357b70d 100644
>>> --- a/Documentation/fpga/index.rst
>>> +++ b/Documentation/fpga/index.rst
>>> @@ -8,6 +8,7 @@ fpga
>>>       :maxdepth: 1
>>>
>>>       dfl
>>> +    xrt
>>>
>>>   .. only::  subproject and html
>>>
>>> diff --git a/Documentation/fpga/xrt.rst b/Documentation/fpga/xrt.rst
>>> new file mode 100644
>>> index 000000000000..323ded5c0f4a
>>> --- /dev/null
>>> +++ b/Documentation/fpga/xrt.rst
>>> @@ -0,0 +1,510 @@
>>> +.. SPDX-License-Identifier: GPL-2.0
>>> +
>>> +==================================
>>> +XRTV2 Linux Kernel Driver Overview
>>> +==================================
>>> +
>>> +Authors:
>>> +
>>> +* Sonal Santan <sonal.santan@xilinx.com>
>>> +* Max Zhen <max.zhen@xilinx.com>
>>> +* Lizhi Hou <lizhi.hou@xilinx.com>
>>> +
>>> +XRTV2 drivers are second generation `XRT 
>>> <https://github.com/Xilinx/XRT>`_
>>> +drivers which support `Alveo 
>>> <https://www.xilinx.com/products/boards-and-kits/alveo.html>`_
>>> +PCIe platforms from Xilinx.
>>> +
>>> +XRTV2 drivers support *subsystem* style data driven platforms where 
>>> driver's
>>> +configuration and behavior are determined by metadata provided by 
>>> the platform
>>> +(in *device tree* format). Primary management physical function 
>>> (MPF) driver
>>> +is called **xrt-mgmt**. Primary user physical function (UPF) driver 
>>> is called
>>> +**xrt-user** and is under development. xrt_driver framework and 
>>> FPGA subsystem
>>> +drivers are packaged into a library module called **xrt-lib**, 
>>> which is shared
>>> +by **xrt-mgmt** and **xrt-user** (under development). The 
>>> xrt_driver framework
>>> +implements a ``bus_type`` called **xrt_bus_type** which is used to 
>>> discover HW
>>> +subsystems and facilitate inter HW subsystem interaction.
>>> +
>>> +Driver Modules
>>> +==============
>>> +
>>> +xrt-lib.ko
>>> +----------
>>> +
>>> +xrt-lib is the repository of xrt drivers and pure software modules 
>>> that can
>>> +potentially be shared between xrt-mgmt and xrt-user. All these 
>>> drivers are
>>> +structured as **xrt_driver** and are instantiated by xrt-mgmt (or 
>>> xrt-user under
>>> +development) based on the metadata associated with the hardware.  
>>> The metadata
>>> +is in the form of a device tree as mentioned before.
>>> +
>>> +xrt-lib relies on OF kernel APIs to unflatten the metadata and 
>>> overlay the
>>> +unflattened device tree nodes to system device tree. In xrt-lib 
>>> module initialization
>>> +routine, "/xrt-bus" is created in system device tree, all XRT device
>>> +tree nodes and properties will be under "/xrt-bus".
>>> +
>>> +The xrt-lib infrastructure provides hooks to xrt_drivers for device 
>>> node
>>> +management, user file operations and ioctl callbacks. The core 
>>> infrastructure also
>>> +provides a bus functionality called **xrt_bus_type** for xrt_driver 
>>> registration,
>>> +discovery and inter xrt_driver calls. xrt-lib does not have any 
>>> dependency on PCIe
>>> +subsystem.
>>> +
>>> +xrt-mgmt.ko
>>> +------------
>>> +
>>> +The xrt-mgmt driver is a PCIe device driver driving MPF found on 
>>> Xilinx's Alveo
>>> +PCIe device. It creates one or more *group* device and one or more 
>>> *xleaf* device.
>>> +The group and xleaf drivers are in xrt-lib and instantiations of 
>>> the xrt_driver but
>>> +are called group and xleaf to symbolize the logical operation 
>>> performed by them.
>>> +
>>> +The xrt-mgmt driver uses xrt-lib APIs to manages the life cycle of 
>>> multiple group
>>> +drivers, which, in turn, manages multiple xleaf drivers. This 
>>> flexibility allows
>>> +xrt-mgmt.ko and xrt-lib.ko to support various HW subsystems exposed 
>>> by different
>>> +Alveo shells. The differences among these Alveo shells is handled 
>>> in xleaf drivers.
>>> +The group driver is part of the infrastructure which provides 
>>> common services to xleaf
>>> +drivers found on various Alveo shells. See 
>>> :ref:`alveo_platform_overview`.
>>> +
>>> +The instantiation of specific group driver or xleaf drivers is 
>>> completely data
>>> +driven based on metadata (mostly in device tree format) found 
>>> through VSEC
>>> +capability and inside the firmware files, such as platform xsabin 
>>> or user xclbin
>>> +file.
>>> +
>>> +
>>> +Driver Object Model
>>> +===================
>>> +
>>> +The driver object model looks like the following::
>>> +
>>> +                              +-----------+
>>> +                              |  of root  |
>>> +                              +-----+-----+
>>> +                                    |
>>> +                          +---------+---------+
>>> +                          |                   |
>>> +                    +-----------+        +----------+
>>> +                    |  xrt-bus  |        |   ...    |
>>> +                    +-----+-----+        +----------+
>>> +                          |
>>> +              +-----------+-----------+
>>> +              |                       |
>>> +              v                       v
>>> +        +-----------+          +-----------+
>>> +        |   group   |    ...   |   group   |
>>> +        +-----+-----+          +------+----+
>>> +              |                       |
>>> +              |                       |
>>> +        +-----+----+            +-----+----+
>>> +        |          |            |          |
>>> +        v          v            v          v
>>> +    +-------+  +-------+    +-------+  +-------+
>>> +    | xleaf |..| xleaf |    | xleaf |..| xleaf |
>>> +    +-------+  +-------+    +-------+  +-------+
>>> +
>>> +As an example, for Xilinx Alveo U50 before user xclbin download, 
>>> the tree
>>> +looks like the following::
>>> +
>>> +                                +-----------+
>>> +                                |  xrt-bus  |
>>> +                                +-----+-----+
>>> +                                      |
>>> +            +-------------------------+--------------------+
>>> +            |                         |                    |
>>> +            v                         v                    v
>>> +       +--------+                +--------+ +--------+
>>> +       | group0 |                | group1 |            | group2 |
>>> +       +----+---+                +----+---+ +---+----+
>>> +            |                         |                    |
>>> +            |                         |                    |
>>> +      +-----+-----+        +----+-----+---+ 
>>> +-----+-----+----+--------+
>>> +      |           |        |    |         |    | |          |        |
>>> +      v           v        |    v         v    | v          v        |
>>> + +------------+  +------+  | +------+ +------+ |  +------+ 
>>> +-----------+ |
>>> + | xmgmt_main |  | VSEC |  | | GPIO | | QSPI | |  |  CMC | | 
>>> AXI-GATE0 | |
>>> + +------------+  +------+  | +------+ +------+ |  +------+ 
>>> +-----------+ |
>>> +                           | +---------+       |  +------+ 
>>> +-----------+ |
>>> +                           +>| MAILBOX |       +->| ICAP | | 
>>> AXI-GATE1 |<+
>>> +                             +---------+       |  +------+ 
>>> +-----------+
>>> +                                               |  +-------+
>>> +                                               +->| CALIB |
>>> +                                                  +-------+
>> These leaves are all part of the Management Physical Function(MPF), 
>> is it?
>> But why are they assigned in different groups from software perspective?
We will remove the group device nodes. The device structure will reflect 
the hardware.
>>
>>> +
>>> +After a xclbin is downloaded, group3 will be added and the tree 
>>> looks like the
>>> +following::
>>> +
>>> +                                +-----------+
>>> +                                |  xrt-bus  |
>>> +                                +-----+-----+
>>> +                                      |
>>> + +-------------------------+--------------------+-----------------+
>>> +            |                         | |                 |
>>> +            v                         v v                 |
>>> +       +--------+                +--------+ +--------+            |
>>> +       | group0 |                | group1 |            | group2 
>>> |            |
>>> +       +----+---+                +----+---+ +---+----+            |
>>> +            |                         | |                 |
>>> +            |                         | |                 |
>>> +      +-----+-----+       +-----+-----+---+ 
>>> +-----+-----+----+--------+   |
>>> +      |           |       |     |         |    | |          
>>> |        |   |
>>> +      v           v       |     v         v    | v          
>>> v        |   |
>>> + +------------+  +------+ | +------+ +------+  |  +------+ 
>>> +-----------+ |   |
>>> + | xmgmt_main |  | VSEC | | | GPIO | | QSPI |  |  |  CMC | | 
>>> AXI-GATE0 | |   |
>>> + +------------+  +------+ | +------+ +------+  |  +------+ 
>>> +-----------+ |   |
>>> +                          | +---------+        |  +------+ 
>>> +-----------+ |   |
>>> +                          +>| MAILBOX |        +->| ICAP | | 
>>> AXI-GATE1 |<+   |
>>> +                            +---------+        |  +------+ 
>>> +-----------+     |
>>> +                                               | 
>>> +-------+                  |
>>> +                                               +->| CALIB 
>>> |                  |
>>> + +-------+                  |
>>> + +---+----+                                             |
>>> +                      | group3 
>>> |<--------------------------------------------+
>>> +                      +--------+
>>> +                          |
>>> +                          |
>>> +     +-------+--------+---+--+--------+------+-------+
>>> +     |       |        |      |        |      |       |
>>> +     v       |        v      |        v      |       v
>>> + +--------+  |   +--------+  |   +--------+  |    +-----+
>>> + | CLOCK0 |  |   | CLOCK1 |  |   | CLOCK2 |  |    | UCS |
>>> + +--------+  v   +--------+  v   +--------+  v    +-----+
>>> + +-------------+ +-------------+ +-------------+
>>> + | CLOCK-FREQ0 | | CLOCK-FREQ1 | | CLOCK-FREQ2 |
>>> + +-------------+ +-------------+ +-------------+
>>> +
>>> +
>>> +group
>>> +-----
>>> +
>>> +The group driver represents a pseudo device whose life cycle is 
>>> managed by
>>> +root and does not have real IO mem or IRQ resources. It's part of the
>>> +infrastructure of the MPF driver and resides in xrt-lib.ko. This 
>>> driver
>> I'm not quite understand the neccessity of the group device & driver.
>>
>>> +
>>> +* manages one or more xleaf drivers
>> The xleaf devices could be enumerated & managed by one root driver 
>> (maybe the
>> PCIe driver for the card). Why we need group drivers to do it part by 
>> part?
>> Maybe this is the same question as the first one.
>>
>>> +* handle requests from xleaf drivers. For example event 
>>> notifications and
>>> +  inter xleaf calls.
>> There are many ways in kernel for direct communication between two 
>> device
>> drivers according to their functionalies. Is it necessary we introduce a
>> new mechanism for general communication across all kinds of devices 
>> under
>> xroot?
We will define call back function table in leaf driver instead of xleaf 
call.
>>
>>> +
>>> +In xrt-mgmt, an initial group driver instance will be created by 
>>> the PCIe driver.
>>> +This instance contains xleaf drivers that will trigger group 
>>> instances to be
>>> +created to manage groups of xleaf drivers found on different 
>>> partitions of
>>> +hardware, such as VSEC, Shell, and User.
>>> +
>>> +xleaf
>>> +-----
>>> +
>>> +The xleaf driver is a xrt_driver whose life cycle is managed by
>>> +a group driver and may or may not have real IO mem or IRQ 
>>> resources. They
>>> +manage HW subsystems they are attached to.
>>> +
>>> +A xleaf driver without real hardware resources manages in-memory 
>>> states for
>>> +xrt-mgmt. These states are shareable by other xleaf drivers.
>>> +
>>> +Xleaf drivers assigned to specific hardware resources drive a 
>>> specific subsystem
>>> +in the device. To manipulate the subsystem or carry out a task, a 
>>> xleaf driver
>>> +may ask for help from the root via root calls and/or from other 
>>> leaves via
>>> +inter xleaf calls.
>>> +
>>> +A xleaf can also broadcast events through infrastructure code for 
>>> other leaves
>>> +to process. It can also receive event notification from 
>>> infrastructure about
>>> +certain events, such as post-creation or pre-exit of a particular 
>>> xleaf.
>>> +
>>> +xrt_bus_type
>>> +------------
>>> +
>>> +xrt_bus_type defines a virtual bus which handles xrt_driver probe, 
>>> remove and match
>>> +operations. All xrt_drivers register with xrt_bus_type as part of 
>>> xrt-lib driver
>>> +``module_init`` and un-register as part of xrt-lib driver 
>>> ``module_exit``.
>> Do we still need the xrt_bus? Seems it all it does is the OF style 
>> device-driver matching.
>>  From my perspective, the main part of the patchset is to dynamically 
>> add some mmio sub
>> devices under a parent PCI device and they are enumerated by DT 
>> overlay. Maybe it is
>> much easier just implement them as platform devices, then you could 
>> leverage the
>> of/platform enumeration. You could also leverage the drivers for IP 
>> blocks that are
>> already supported. We don't need both the xrt_driver and 
>> platform_driver for the same
>> IP blocks just because they are placed on different boards.

Because we are remodeling our driver to use unflattened device tree. And 
all the current xleaf devices are able to matching by 'compatible'. We 
agree that leveraging platform device/driver is simpler.

There was a discussion among Moritz, Tom and us for platform_bus/xrt_bus.

  https://lore.kernel.org/lkml/BY5PR02MB6260F99A93646FD560BCB86ABB939@BY5PR02MB6260.namprd02.prod.outlook.com/

Moritz and Tom, does it make sense to you for using platform_bus instead 
of introducing xrt_bus?


Thanks,

Lizhi

>>
>> Thanks,
>> Yilun
>>
>>> +
>>> +FPGA Manager Interaction
>>> +========================
>>> +
>>> +fpga_manager
>>> +------------
>>> +
>>> +An instance of fpga_manager is created by xmgmt_main and is used 
>>> for xclbin
>>> +image download. fpga_manager requires the full xclbin image before 
>>> it can
>>> +start programming the FPGA configuration engine via Internal 
>>> Configuration
>>> +Access Port (ICAP) xrt_driver.
>>> +
>>> +fpga_region
>>> +-----------
>>> +
>>> +For every interface exposed by the currently loaded xclbin/xsabin 
>>> in the
>>> +*parent* fpga_region a new instance of fpga_region is created like 
>>> a *child*
>>> +fpga_region. The device tree of the *parent* fpga_region defines the
>>> +resources for a new instance of fpga_bridge which isolates the 
>>> parent from
>>> +child fpga_region. This new instance of fpga_bridge will be used 
>>> when a
>>> +xclbin image is loaded on the child fpga_region. After the xclbin 
>>> image is
>>> +downloaded to the fpga_region, an instance of a group is created 
>>> for the
>>> +fpga_region using the device tree obtained as part of the xclbin. 
>>> If this
>>> +device tree defines any child interfaces, it can trigger the 
>>> creation of
>>> +fpga_bridge and fpga_region for the next region in the chain.
>>> +
>>> +fpga_bridge
>>> +-----------
>>> +
>>> +Like the fpga_region, an fpga_bridge is created by walking the 
>>> device tree
>>> +of the parent group. The bridge is used for isolation between a 
>>> parent and
>>> +its child.
>>> +
>>> +Driver Interfaces
>>> +=================
>>> +
>>> +xrt-mgmt Driver Ioctls
>>> +----------------------
>>> +
>>> +Ioctls exposed by the xrt-mgmt driver to user space are enumerated 
>>> in the
>>> +following table:
>>> +
>>> +== ===================== ============================ 
>>> ==========================
>>> +#  Functionality         ioctl request code            data format
>>> +== ===================== ============================ 
>>> ==========================
>>> +1  FPGA image download   XMGMT_IOCICAPDOWNLOAD_AXLF 
>>> xmgmt_ioc_bitstream_axlf
>>> +== ===================== ============================ 
>>> ==========================
>>> +
>>> +A user xclbin can be downloaded by using the xbmgmt tool from the 
>>> XRT open source
>>> +suite. See example usage below::
>>> +
>>> +  xbmgmt partition --program --path 
>>> /lib/firmware/xilinx/862c7020a250293e32036f19956669e5/test/verify.xclbin 
>>> --force
>>> +
>>> +.. _alveo_platform_overview:
>>> +
>>> +Alveo Platform Overview
>>> +=======================
>>> +
>>> +Alveo platforms are architected as two physical FPGA partitions: 
>>> *Shell* and
>>> +*User*. The Shell provides basic infrastructure for the Alveo 
>>> platform like
>>> +PCIe connectivity, board management, Dynamic Function Exchange 
>>> (DFX), sensors,
>>> +clocking, reset, and security. DFX, partial reconfiguration, is 
>>> responsible for
>>> +loading the user compiled FPGA binary.
>>> +
>>> +For DFX to work properly, physical partitions require strict HW 
>>> compatibility
>>> +with each other. Every physical partition has two interface UUIDs: 
>>> the *parent*
>>> +UUID and the *child* UUID. For simple single stage platforms, Shell 
>>> → User forms
>>> +the parent child relationship.
>>> +
>>> +.. note::
>>> +   Partition compatibility matching is a key design component of 
>>> the Alveo platforms
>>> +   and XRT. Partitions have child and parent relationship. A loaded 
>>> partition
>>> +   exposes child partition UUID to advertise its compatibility 
>>> requirement. When
>>> +   loading a child partition, the xrt-mgmt driver matches the parent
>>> +   UUID of the child partition against the child UUID exported by 
>>> the parent.
>>> +   The parent and child partition UUIDs are stored in the *xclbin* 
>>> (for the user)
>>> +   and the *xsabin* (for the shell). Except for the root UUID 
>>> exported by VSEC,
>>> +   the hardware itself does not know about the UUIDs. The UUIDs are 
>>> stored in
>>> +   xsabin and xclbin. The image format has a special node called 
>>> Partition UUIDs
>>> +   which define the compatibility UUIDs.
>>> +
>>> +
>>> +The physical partitions and their loading are illustrated below::
>>> +
>>> +           SHELL                               USER
>>> +        +-----------+                  +-------------------+
>>> +        |           |                  |                   |
>>> +        | VSEC UUID | CHILD     PARENT |    LOGIC UUID     |
>>> +        | o------->|<--------o                   |
>>> +        |           | UUID       UUID  |                   |
>>> +        +-----+-----+                  +--------+----------+
>>> +              |                                 |
>>> +              .                                 .
>>> +              |                                 |
>>> +          +---+---+                      +------+--------+
>>> +          |  POR  |                      | USER COMPILED |
>>> +          | FLASH |                      |    XCLBIN     |
>>> +          +-------+                      +---------------+
>>> +
>>> +
>>> +Loading Sequence
>>> +----------------
>>> +
>>> +The Shell partition is loaded from flash at system boot time. It 
>>> establishes the
>>> +PCIe link and exposes two physical functions to the BIOS. After the 
>>> OS boots,
>>> +the xrt-mgmt driver attaches to the PCIe physical function 0 
>>> exposed by the Shell
>>> +and then looks for VSEC in the PCIe extended configuration space. 
>>> Using VSEC, it
>>> +determines the logic UUID of the Shell and uses the UUID to load 
>>> matching *xsabin*
>>> +file from Linux firmware directory. The xsabin file contains the 
>>> metadata to
>>> +discover the peripherals that are part of the Shell and the 
>>> firmware for any
>>> +embedded soft processors in the Shell. The xsabin file also 
>>> contains Partition
>>> +UUIDs.
>>> +
>>> +The Shell exports a child interface UUID which is used for the 
>>> compatibility
>>> +check when loading the user compiled xclbin over the User partition 
>>> as part of DFX.
>>> +When a user requests loading of a specific xclbin, the xrt-mgmt 
>>> driver reads
>>> +the parent interface UUID specified in the xclbin and matches it 
>>> with the child
>>> +interface UUID exported by the Shell to determine if the xclbin is 
>>> compatible with
>>> +the Shell. If the match fails, loading of xclbin is denied.
>>> +
>>> +xclbin loading is requested using the ICAP_DOWNLOAD_AXLF ioctl 
>>> command. When loading
>>> +a xclbin, the xrt-mgmt driver performs the following *logical* 
>>> operations:
>>> +
>>> +1. Copy xclbin from user to kernel memory
>>> +2. Sanity check the xclbin contents
>>> +3. Isolate the User partition
>>> +4. Download the bitstream using the FPGA config engine (ICAP)
>>> +5. De-isolate the User partition
>>> +6. Program the clocks (ClockWiz) driving the User partition
>>> +7. Wait for the memory controller (MIG) calibration
>>> +8. Return the loading status back to the caller
>>> +
>>> +`Platform Loading Overview 
>>> <https://xilinx.github.io/XRT/master/html/platforms_partitions.html>`_
>>> +provides more detailed information on platform loading.
>>> +
>>> +
>>> +xsabin
>>> +------
>>> +
>>> +Each Alveo platform comes packaged with its own xsabin. The xsabin 
>>> is a trusted
>>> +component of the platform. For format details refer to 
>>> :ref:`xsabin_xclbin_container_format`
>>> +below. xsabin contains basic information like UUIDs, platform name 
>>> and metadata in the
>>> +form of device tree. See :ref:`device_tree_usage` below for details 
>>> and example.
>>> +
>>> +xclbin
>>> +------
>>> +
>>> +xclbin is compiled by end user using
>>> +`Vitis 
>>> <https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html>`_
>>> +tool set from Xilinx. The xclbin contains sections describing user 
>>> compiled
>>> +acceleration engines/kernels, memory subsystems, clocking 
>>> information etc. It also
>>> +contains an FPGA bitstream for the user partition, UUIDs, platform 
>>> name, etc.
>>> +
>>> +
>>> +.. _xsabin_xclbin_container_format:
>>> +
>>> +xsabin/xclbin Container Format
>>> +------------------------------
>>> +
>>> +xclbin/xsabin is ELF-like binary container format. It is structured 
>>> as series of
>>> +sections. There is a file header followed by several section 
>>> headers which is
>>> +followed by sections. A section header points to an actual section. 
>>> There is an
>>> +optional signature at the end. The format is defined by the header 
>>> file ``xclbin.h``.
>>> +The following figure illustrates a typical xclbin::
>>> +
>>> +
>>> +           +---------------------+
>>> +           |                     |
>>> +           |       HEADER        |
>>> +           +---------------------+
>>> +           |   SECTION  HEADER   |
>>> +           |                     |
>>> +           +---------------------+
>>> +           |         ...         |
>>> +           |                     |
>>> +           +---------------------+
>>> +           |   SECTION  HEADER   |
>>> +           |                     |
>>> +           +---------------------+
>>> +           |       SECTION       |
>>> +           |                     |
>>> +           +---------------------+
>>> +           |         ...         |
>>> +           |                     |
>>> +           +---------------------+
>>> +           |       SECTION       |
>>> +           |                     |
>>> +           +---------------------+
>>> +           |      SIGNATURE      |
>>> +           |      (OPTIONAL)     |
>>> +           +---------------------+
>>> +
>>> +
>>> +xclbin/xsabin files can be packaged, un-packaged and inspected 
>>> using an XRT
>>> +utility called **xclbinutil**. xclbinutil is part of the XRT open 
>>> source
>>> +software stack. The source code for xclbinutil can be found at
>>> +https://github.com/Xilinx/XRT/tree/master/src/runtime_src/tools/xclbinutil 
>>>
>>> +
>>> +For example, to enumerate the contents of a xclbin/xsabin use the 
>>> *--info* switch
>>> +as shown below::
>>> +
>>> +
>>> +  xclbinutil --info --input 
>>> /opt/xilinx/firmware/u50/gen3x16-xdma/blp/test/bandwidth.xclbin
>>> +  xclbinutil --info --input 
>>> /lib/firmware/xilinx/862c7020a250293e32036f19956669e5/partition.xsabin
>>> +
>>> +
>>> +.. _device_tree_usage:
>>> +
>>> +Device Tree Usage
>>> +-----------------
>>> +
>>> +The xsabin file stores metadata which advertise HW subsystems 
>>> present in a
>>> +partition. The metadata is stored in device tree format with a well 
>>> defined
>>> +schema. XRT management driver uses this information to create 
>>> *xrt_devices* and
>>> +bind *xrt_drivers* to them. The xrt_drivers could be independent 
>>> modules or
>>> +found in **xrt-lib.ko** kernel module.
>>> +
>>> +Deployment Models
>>> +=================
>>> +
>>> +Baremetal
>>> +---------
>>> +
>>> +In bare-metal deployments, both MPF and UPF are visible and 
>>> accessible. The
>>> +xrt-mgmt driver binds to MPF. The xrt-mgmt driver operations are 
>>> privileged and
>>> +available to system administrator. The full stack is illustrated 
>>> below::
>>> +
>>> +                            HOST
>>> +
>>> +               [XRT-MGMT]         [XRT-USER]
>>> +                    |                  |
>>> +                    |                  |
>>> +                 +-----+            +-----+
>>> +                 | MPF |            | UPF |
>>> +                 |     |            |     |
>>> +                 | PF0 |            | PF1 |
>>> +                 +--+--+            +--+--+
>>> +          ......... ^................. ^..........
>>> +                    |                  |
>>> +                    |   PCIe DEVICE    |
>>> +                    |                  |
>>> +                 +--+------------------+--+
>>> +                 |         SHELL          |
>>> +                 |                        |
>>> +                 +------------------------+
>>> +                 |         USER           |
>>> +                 |                        |
>>> +                 |                        |
>>> +                 |                        |
>>> +                 |                        |
>>> +                 +------------------------+
>>> +
>>> +
>>> +
>>> +Virtualized
>>> +-----------
>>> +
>>> +In virtualized deployments, the privileged MPF is assigned to the 
>>> host but the
>>> +unprivileged UPF is assigned to a guest VM via PCIe pass-through. 
>>> The xrt-mgmt
>>> +driver in host binds to MPF. The xrt-mgmt driver operations are 
>>> privileged and
>>> +only accessible to the MPF. The full stack is illustrated below::
>>> +
>>> +
>>> +                                 ..............
>>> +                  HOST           .    VM      .
>>> +                                 .            .
>>> +               [XRT-MGMT]        . [XRT-USER] .
>>> +                    |            .     |      .
>>> +                    |            .     |      .
>>> +                 +-----+         .  +-----+   .
>>> +                 | MPF |         .  | UPF |   .
>>> +                 |     |         .  |     |   .
>>> +                 | PF0 |         .  | PF1 |   .
>>> +                 +--+--+         .  +--+--+   .
>>> +          ......... ^................. ^..........
>>> +                    |                  |
>>> +                    |   PCIe DEVICE    |
>>> +                    |                  |
>>> +                 +--+------------------+--+
>>> +                 |         SHELL          |
>>> +                 |                        |
>>> +                 +------------------------+
>>> +                 |         USER           |
>>> +                 |                        |
>>> +                 |                        |
>>> +                 |                        |
>>> +                 |                        |
>>> +                 +------------------------+
>>> +
>>> +
>>> +
>>> +
>>> +
>>> +Platform Security Considerations
>>> +================================
>>> +
>>> +`Security of Alveo Platform 
>>> <https://xilinx.github.io/XRT/master/html/security.html>`_
>>> +discusses the deployment options and security implications in great 
>>> detail.
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 80eebc1d9ed5..fd7053bcfdb0 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -7369,6 +7369,16 @@ F:     Documentation/fpga/
>>>   F:   drivers/fpga/
>>>   F:   include/linux/fpga/
>>>
>>> +FPGA XRT DRIVERS
>>> +M:   Lizhi Hou <lizhi.hou@xilinx.com>
>>> +R:   Max Zhen <max.zhen@xilinx.com>
>>> +R:   Sonal Santan <sonal.santan@xilinx.com>
>>> +L:   linux-fpga@vger.kernel.org
>>> +S:   Supported
>>> +W:   https://github.com/Xilinx/XRT
>>> +F:   Documentation/fpga/xrt.rst
>>> +F:   drivers/fpga/xrt/
>>> +
>>>   FPU EMULATOR
>>>   M:   Bill Metzenthen <billm@melbpc.org.au>
>>>   S:   Maintained
>>> -- 
>>> 2.27.0
