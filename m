Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C48D328B69
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Mar 2021 19:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbhCASdm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Mar 2021 13:33:42 -0500
Received: from mail-bn8nam11on2061.outbound.protection.outlook.com ([40.107.236.61]:29768
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239836AbhCASaQ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Mar 2021 13:30:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SwsbnCNyTiH0JEycYmBkJnSoYpyES8u8fTVEjOgbpxk67N/prRqar+lB1zFQTuA1Nt+owmO/mE5HyFnKUBHkXNq/CRYu0eWUW+gejD89/XAmD9FVjCPkvsNvee4dKKBfP7Cz0EJ6NibF/EnUR5qKdqvdgRAC48zYcT6XhOqpRzxowTal1XqK9bBuW0ehLJ+ZdBChgmqBWtsiFHkizCXW/SCjFHPCFu3FTU+1kmRioNOrs5jNpN9W+vUtQYiw/Gh8/5NUHMT1flQMB43MRraQssph3knFdxul4Gt1MvyJFgJhZM+Yg88A/K5o7rn7cTGscIGO3gfBRdZtWNTQ/Ome5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkPR2+SGkTS4iWDS+EmJkl1SiQ5/MNsTSykXcvPuDOI=;
 b=bt9KL6ECEF1Enl/bhEjfbw71PS0EjUKK/9RImliURZ5m7S7O+XF0mlSHdw4K1cCJcbnP5rA0OJmwN1zz1XktHyCHlpJDPY+a2mA7dB7/hkLg4JIM6LyL4GHgwlVJuXv8G4Mgx1q6USIQsmt/L4mVP3bO698JLB/6H3cCHGVhsmd2VgF0zue14FALZN7ob35/liwWGfpBvGgfY8brcx/4MASVWCaChKua1iaGTQZ0OJnsTtMWd0XL+hH196GnRDnd4lEBwW8kKN9z9Cc+ZsUS+IuhnWgs9U8RhlT6q8Q1bRnOWD1lgGSdLgo1SUf5n/rPTTl8h9qjNDrPiBmwH1jJYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkPR2+SGkTS4iWDS+EmJkl1SiQ5/MNsTSykXcvPuDOI=;
 b=CwdcZXkViBTZMD0kDl0jfht134cXNbAsvRX2JI3KGscnrd7btTR5wBig/OrMOv5yd29JQ5vm+j2SZ/Xxmw2uK1qxMeN2v8TecpKViUwN7Diftz/qlQ4ycgcVlvbSA7lTuwSpNRiElPXLGxr2wI2n/0T80AIWjD4ROBZ2MOhhU7I=
Received: from SA9PR11CA0017.namprd11.prod.outlook.com (2603:10b6:806:6e::22)
 by CH2PR02MB6679.namprd02.prod.outlook.com (2603:10b6:610:7a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Mon, 1 Mar
 2021 18:29:18 +0000
Received: from SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:6e:cafe::15) by SA9PR11CA0017.outlook.office365.com
 (2603:10b6:806:6e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.21 via Frontend
 Transport; Mon, 1 Mar 2021 18:29:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT055.mail.protection.outlook.com (10.152.72.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 18:29:18 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 1 Mar 2021 10:29:12 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 1 Mar 2021 10:29:12 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhi.hou@xilinx.com,
 stefanos@xilinx.com,
 maxz@xilinx.com,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 mdf@kernel.org
Received: from [10.17.2.60] (port=47618)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lGnI7-0002kP-Vn; Mon, 01 Mar 2021 10:29:12 -0800
Subject: Re: [PATCH V3 XRT Alveo 00/18] XRT Alveo driver overview
To:     Moritz Fischer <mdf@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <robh@kernel.org>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <YDLF2Bi3oEhP6A7Q@archbook>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <f85b48e2-155a-c42c-9b47-5098421c554f@xilinx.com>
Date:   Mon, 1 Mar 2021 10:29:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <YDLF2Bi3oEhP6A7Q@archbook>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26cb8096-2eb1-4951-80b3-08d8dcdfecdd
X-MS-TrafficTypeDiagnostic: CH2PR02MB6679:
X-MS-Exchange-MinimumUrlDomainAge: xilinx.github.io#0
X-Microsoft-Antispam-PRVS: <CH2PR02MB6679988031034D6641145CEAA19A9@CH2PR02MB6679.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 77AA0qRjw7h06ZUaTfUzQJTJB0mzLuqPFTvhdmz+fVAqz6n2wYHO9xkdCufRO+4W7C7JSD3YHAPCjMQcUeJ3UVJBPMwL2EjspmojPVibf6pcnCend4EG9b6RysBCYm5bY7p0EaaVuoQkOTN3vR1mTUA0nQTVyr51VzZ4AWIBIxjdKdZLUPzCq4xJToqsGDeYZUAuUnwCDdXs0ffHH93rlje2MAjenlx4EajiF/o+AsxLmvkP08Ex0EPNPI039uZ67f60b9q0jd/9Bd90OjCf/hlEJ5l4ZdPDxQu3lVTm47xOftX2K49cRnYetmFllGa4SQGaD1MOcnPEC1UMd33eTBjGJvq/LwTWvX6f5hXj/dZXkx81GhY6sN5wV2J3I0nOazAWTlssjt1M9LHS1W5Nk8lpa8RyEVvbJKlFB3r2fPwA8Hwlmnz3+Cx7Mu+8F1qckJWVfV56bsi9dp/4H4qaerjiUcmOAY2+0lEsYuZJr6pxJZ4tYEZJgl0O3N0X56jgB7z/nPiQfpqUSYDkJf0vS8c9fEiTjkz4ig3x293/uY+XT/qePZm+aMXKyjORmIrVFqVMIwTSrpUSC0DFPX7EQp0KQGUZ+FJ+RApOHEBOpTy4WE5QIk5WZx51JPwOTFtwPVWrA3cm9sKLiWwcPzawRFmvplmqxF8Da2j7LGRBY4UQ7eWDQmKDQtLAYS5kajLoo+7alnGdauCPNWPv/i4MwUDpVRsQh7F3khx8o0alp2ubslai+RoZTAYVrbE2cqTs07XP0UYsHh3xqKVwwTVsvxjGrolza4nNMByzRyNibts=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(36840700001)(46966006)(26005)(47076005)(2906002)(8676002)(336012)(70206006)(426003)(31696002)(2616005)(70586007)(186003)(9786002)(30864003)(8936002)(44832011)(31686004)(36756003)(5660300002)(110136005)(478600001)(54906003)(966005)(83380400001)(316002)(36906005)(53546011)(4326008)(356005)(82310400003)(7636003)(36860700001)(82740400003)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 18:29:18.1872
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cb8096-2eb1-4951-80b3-08d8dcdfecdd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6679
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,


On 02/21/2021 12:43 PM, Moritz Fischer wrote:
> Lizhi,
>
> On Wed, Feb 17, 2021 at 10:40:01PM -0800, Lizhi Hou wrote:
>> Hello,
>>
>> This is V3 of patch series which adds management physical function driver for Xilinx
>> Alveo PCIe accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
>> This driver is part of Xilinx Runtime (XRT) open source stack.
>>
>> XILINX ALVEO PLATFORM ARCHITECTURE
>>
>> Alveo PCIe FPGA based platforms have a static *shell* partition and a partial
>> re-configurable *user* partition. The shell partition is automatically loaded from
>> flash when host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
>> till the next cold reboot. The shell exposes two PCIe physical functions:
>>
>> 1. management physical function
>> 2. user physical function
>>
>> The patch series includes Documentation/xrt.rst which describes Alveo platform,
>> XRT driver architecture and deployment model in more detail.
>>
>> Users compile their high level design in C/C++/OpenCL or RTL into FPGA image using
>> Vitis https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
>> tools. The compiled image is packaged as xclbin which contains partial bitstream
>> for the user partition and necessary metadata. Users can dynamically swap the image
>> running on the user partition in order to switch between different workloads by
>> loading different xclbins.
>>
>> XRT DRIVERS FOR XILINX ALVEO
>>
>> XRT Linux kernel driver *xmgmt* binds to management physical function of Alveo
>> platform. The modular driver framework is organized into several platform drivers
>> which primarily handle the following functionality:
>>
>> 1.  Loading firmware container also called xsabin at driver attach time
>> 2.  Loading of user compiled xclbin with FPGA Manager integration
>> 3.  Clock scaling of image running on user partition
>> 4.  In-band sensors: temp, voltage, power, etc.
>> 5.  Device reset and rescan
>>
>> The platform drivers are packaged into *xrt-lib* helper module with well
>> defined interfaces. The module provides a pseudo-bus implementation for the
>> platform drivers. More details on the driver model can be found in
>> Documentation/xrt.rst.
>>
>> User physical function driver is not included in this patch series.
>>
>> LIBFDT REQUIREMENT
>>
>> XRT driver infrastructure uses Device Tree as a metadata format to discover
>> HW subsystems in the Alveo PCIe device. The Device Tree schema used by XRT
>> is documented in Documentation/xrt.rst. Unlike previous V1 and V2 version
>> of patch series, V3 version does not require export of libfdt symbols.
>>
>> TESTING AND VALIDATION
>>
>> xmgmt driver can be tested with full XRT open source stack which includes user
>> space libraries, board utilities and (out of tree) first generation user physical
>> function driver xocl. XRT open source runtime stack is available at
>> https://github.com/Xilinx/XRT
>>
>> Complete documentation for XRT open source stack including sections on Alveo/XRT
>> security and platform architecture can be found here:
>>
>> https://xilinx.github.io/XRT/master/html/index.html
>> https://xilinx.github.io/XRT/master/html/security.html
>> https://xilinx.github.io/XRT/master/html/platforms_partitions.html
>>
>> Changes since v2:
>> - Streamlined the driver framework into *xleaf*, *group* and *xroot*
>> - Updated documentation to show the driver model with examples
>> - Addressed kernel test robot errors
>> - Added a selftest for basic driver framework
>> - Documented device tree schema
>> - Removed need to export libfdt symbols
>>
>> Changes since v1:
>> - Updated the driver to use fpga_region and fpga_bridge for FPGA
>>    programming
>> - Dropped platform drivers not related to PR programming to focus on XRT
>>    core framework
>> - Updated Documentation/fpga/xrt.rst with information on XRT core framework
>> - Addressed checkpatch issues
>> - Dropped xrt- prefix from some header files
>>
>> For reference V1 version of patch series can be found here:
>>
>> https://lore.kernel.org/lkml/20201217075046.28553-1-sonals@xilinx.com/
>> https://lore.kernel.org/lkml/20201217075046.28553-2-sonals@xilinx.com/
>> https://lore.kernel.org/lkml/20201217075046.28553-3-sonals@xilinx.com/
>> https://lore.kernel.org/lkml/20201217075046.28553-4-sonals@xilinx.com/
>> https://lore.kernel.org/lkml/20201217075046.28553-5-sonals@xilinx.com/
>> https://lore.kernel.org/lkml/20201217075046.28553-6-sonals@xilinx.com/
>> https://lore.kernel.org/lkml/20201217075046.28553-7-sonals@xilinx.com/
>>
>> Lizhi Hou (18):
>>    Documentation: fpga: Add a document describing XRT Alveo drivers
>>    fpga: xrt: driver metadata helper functions
>>    fpga: xrt: xclbin file helper functions
>>    fpga: xrt: xrt-lib platform driver manager
>>    fpga: xrt: group platform driver
>>    fpga: xrt: platform driver infrastructure
>>    fpga: xrt: management physical function driver (root)
>>    fpga: xrt: main platform driver for management function device
>>    fpga: xrt: fpga-mgr and region implementation for xclbin download
>>    fpga: xrt: VSEC platform driver
>>    fpga: xrt: UCS platform driver
>>    fpga: xrt: ICAP platform driver
>>    fpga: xrt: devctl platform driver
>>    fpga: xrt: clock platform driver
>>    fpga: xrt: clock frequence counter platform driver
>>    fpga: xrt: DDR calibration platform driver
>>    fpga: xrt: partition isolation platform driver
>>    fpga: xrt: Kconfig and Makefile updates for XRT drivers
>>
>>   Documentation/fpga/index.rst             |   1 +
>>   Documentation/fpga/xrt.rst               | 842 ++++++++++++++++++++++
>>   MAINTAINERS                              |  11 +
>>   drivers/Makefile                         |   1 +
>>   drivers/fpga/Kconfig                     |   2 +
>>   drivers/fpga/Makefile                    |   4 +
>>   drivers/fpga/xrt/Kconfig                 |   8 +
>>   drivers/fpga/xrt/include/events.h        |  48 ++
>>   drivers/fpga/xrt/include/group.h         |  27 +
>>   drivers/fpga/xrt/include/metadata.h      | 229 ++++++
>>   drivers/fpga/xrt/include/subdev_id.h     |  43 ++
>>   drivers/fpga/xrt/include/xclbin-helper.h |  52 ++
>>   drivers/fpga/xrt/include/xleaf.h         | 276 +++++++
>>   drivers/fpga/xrt/include/xleaf/axigate.h |  25 +
>>   drivers/fpga/xrt/include/xleaf/calib.h   |  30 +
>>   drivers/fpga/xrt/include/xleaf/clkfreq.h |  23 +
>>   drivers/fpga/xrt/include/xleaf/clock.h   |  31 +
>>   drivers/fpga/xrt/include/xleaf/devctl.h  |  43 ++
>>   drivers/fpga/xrt/include/xleaf/icap.h    |  29 +
>>   drivers/fpga/xrt/include/xleaf/ucs.h     |  24 +
>>   drivers/fpga/xrt/include/xmgmt-main.h    |  37 +
>>   drivers/fpga/xrt/include/xroot.h         | 114 +++
>>   drivers/fpga/xrt/lib/Kconfig             |  16 +
>>   drivers/fpga/xrt/lib/Makefile            |  30 +
>>   drivers/fpga/xrt/lib/cdev.c              | 231 ++++++
>>   drivers/fpga/xrt/lib/group.c             | 265 +++++++
>>   drivers/fpga/xrt/lib/main.c              | 274 +++++++
>>   drivers/fpga/xrt/lib/main.h              |  17 +
>>   drivers/fpga/xrt/lib/subdev.c            | 871 +++++++++++++++++++++++
>>   drivers/fpga/xrt/lib/subdev_pool.h       |  53 ++
>>   drivers/fpga/xrt/lib/xclbin.c            | 394 ++++++++++
>>   drivers/fpga/xrt/lib/xleaf/axigate.c     | 298 ++++++++
>>   drivers/fpga/xrt/lib/xleaf/calib.c       | 226 ++++++
>>   drivers/fpga/xrt/lib/xleaf/clkfreq.c     | 221 ++++++
>>   drivers/fpga/xrt/lib/xleaf/clock.c       | 648 +++++++++++++++++
>>   drivers/fpga/xrt/lib/xleaf/devctl.c      | 206 ++++++
>>   drivers/fpga/xrt/lib/xleaf/icap.c        | 317 +++++++++
>>   drivers/fpga/xrt/lib/xleaf/ucs.c         | 235 ++++++
>>   drivers/fpga/xrt/lib/xleaf/vsec.c        | 359 ++++++++++
>>   drivers/fpga/xrt/lib/xroot.c             | 598 ++++++++++++++++
>>   drivers/fpga/xrt/metadata/Kconfig        |  12 +
>>   drivers/fpga/xrt/metadata/Makefile       |  16 +
>>   drivers/fpga/xrt/metadata/metadata.c     | 524 ++++++++++++++
>>   drivers/fpga/xrt/mgmt/Kconfig            |  15 +
>>   drivers/fpga/xrt/mgmt/Makefile           |  19 +
>>   drivers/fpga/xrt/mgmt/fmgr-drv.c         | 187 +++++
>>   drivers/fpga/xrt/mgmt/fmgr.h             |  28 +
>>   drivers/fpga/xrt/mgmt/main-impl.h        |  37 +
>>   drivers/fpga/xrt/mgmt/main-region.c      | 471 ++++++++++++
>>   drivers/fpga/xrt/mgmt/main.c             | 693 ++++++++++++++++++
>>   drivers/fpga/xrt/mgmt/root.c             | 342 +++++++++
>>   include/uapi/linux/xrt/xclbin.h          | 408 +++++++++++
>>   include/uapi/linux/xrt/xmgmt-ioctl.h     |  46 ++
>>   53 files changed, 9957 insertions(+)
>>   create mode 100644 Documentation/fpga/xrt.rst
>>   create mode 100644 drivers/fpga/xrt/Kconfig
>>   create mode 100644 drivers/fpga/xrt/include/events.h
>>   create mode 100644 drivers/fpga/xrt/include/group.h
>>   create mode 100644 drivers/fpga/xrt/include/metadata.h
>>   create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>>   create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/calib.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/ucs.h
>>   create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
>>   create mode 100644 drivers/fpga/xrt/include/xroot.h
>>   create mode 100644 drivers/fpga/xrt/lib/Kconfig
>>   create mode 100644 drivers/fpga/xrt/lib/Makefile
>>   create mode 100644 drivers/fpga/xrt/lib/cdev.c
>>   create mode 100644 drivers/fpga/xrt/lib/group.c
>>   create mode 100644 drivers/fpga/xrt/lib/main.c
>>   create mode 100644 drivers/fpga/xrt/lib/main.h
>>   create mode 100644 drivers/fpga/xrt/lib/subdev.c
>>   create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
>>   create mode 100644 drivers/fpga/xrt/lib/xclbin.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/calib.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>>   create mode 100644 drivers/fpga/xrt/lib/xroot.c
>>   create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>>   create mode 100644 drivers/fpga/xrt/metadata/Makefile
>>   create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>>   create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>>   create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>>   create mode 100644 drivers/fpga/xrt/mgmt/fmgr-drv.c
>>   create mode 100644 drivers/fpga/xrt/mgmt/fmgr.h
>>   create mode 100644 drivers/fpga/xrt/mgmt/main-impl.h
>>   create mode 100644 drivers/fpga/xrt/mgmt/main-region.c
>>   create mode 100644 drivers/fpga/xrt/mgmt/main.c
>>   create mode 100644 drivers/fpga/xrt/mgmt/root.c
>>   create mode 100644 include/uapi/linux/xrt/xclbin.h
>>   create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h
>>
>> --
>> 2.18.4
>>
> Please fix the indents all across this patchset. Doesn't checkpatch with
> --strict complain about this?
checkpatch --strict did not complain. And we will fix this.
>
> Also more generally this looks like it should be a bus. Look at DFL for
> reference.
Tom asked the same question in 01/18 and Sonal replied. We may discuss 
with that thread.

Thanks,
Lizhi
>
> - Moritz

