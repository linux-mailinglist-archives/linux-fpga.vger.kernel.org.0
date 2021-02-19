Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8447931F49F
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Feb 2021 06:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBSFQn (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Feb 2021 00:16:43 -0500
Received: from mail-dm6nam11on2063.outbound.protection.outlook.com ([40.107.223.63]:27889
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229644AbhBSFQk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Feb 2021 00:16:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gS2DVwVSaptyTrRvaqDGvk7Kl+qdy7HLXXSBNxAtuzbVIYkKCpnxlgfAvoOb3Us92yHJeZQk76eFa5c318/ons6Tcmki/aIW5gfy9PkF3wnYHhu9j1TJGTmAYMc7py9o2m44AsMT+1GNnRW4pnZWNw36c3mDIX8AT3JS75vWpQHUjNCeNyGzTxGFMTnyRrFVgblcf433zNkxjxLz/uXrqBoP/UD3EuEHxDarjill6HSxwrIppl0d3wEHVh/vxut4B4AkwypPBlilYKBzAziSoFcIINsgteic7uZQHFiZHpmtsHbhfyc1Wm+NtfLdToJygYdqpiwav8kxHVd8pWbvUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xe3AGR+qytfAHtf+cz+nk4GnQPwlNhJjnX4NBbYfgQ=;
 b=mEc/VkvqMIm/QvZozQ+3Tr6QolHGO5gSVv057ZHBsEQ55UzwDiTZ7pbbPkN+ptqvVUKVfnjTwxHA7KJsz9j01h/FsgX0/3VqBhkZdBDJyybazYRaIpn8HZMVQJ+7RsMa4QGqCKEn76ZNY/Er3HvQLj3+uoFVhaBDyvES98WsHsqouGxu+R2wf/GttxATwY2drDeknJr32JFSRHQADf491ftgiig3ZmEVzwQ35ilt3syPNSjoI3Bh8Ooo2HZ1W0UVvKd53kW/kdFc1eSwGD4F8mvYZAjeoH6SrwHujZ3O6Iqabg+ItaIaXq5VnAqDwCfVCxrO/DBMsne/ArBlrIcCrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xe3AGR+qytfAHtf+cz+nk4GnQPwlNhJjnX4NBbYfgQ=;
 b=s7aIxwsou/0kuFONFZX/o6VvkVq4T/Bd6HvsVPj2XuB8w0vR2HcO3NlgvOAEimDAQ/b8I+mnNioKG3J/52fweS+OYHIaLsQZl6iIY4uQ5xy0JAhaDjFlpMe34fXPcAEXhMsvgih1EkGT/tVC7IlQteQff7F0rI6tPFb45mTNA44=
Received: from CY1PR03CA0012.namprd03.prod.outlook.com (2603:10b6:600::22) by
 BN6PR02MB2260.namprd02.prod.outlook.com (2603:10b6:404:2a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.27; Fri, 19 Feb 2021 05:15:46 +0000
Received: from CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:600:0:cafe::5b) by CY1PR03CA0012.outlook.office365.com
 (2603:10b6:600::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Fri, 19 Feb 2021 05:15:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT056.mail.protection.outlook.com (10.152.74.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Fri, 19 Feb 2021 05:15:46 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 18 Feb 2021 21:15:45 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 18 Feb 2021 21:15:45 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhi.hou@xilinx.com,
 stefanos@xilinx.com,
 maxz@xilinx.com,
 robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=49296)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCy8n-0005RI-EK; Thu, 18 Feb 2021 21:15:45 -0800
Subject: Re: [PATCH V3 XRT Alveo 00/18] XRT Alveo driver overview
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <61668981-328b-64ea-0509-950172e5250c@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <4cfc27d3-dd34-02f3-666a-31497eec2b78@xilinx.com>
Date:   Thu, 18 Feb 2021 21:15:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <61668981-328b-64ea-0509-950172e5250c@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb773b5-0ce5-4870-4c5f-08d8d49569ba
X-MS-TrafficTypeDiagnostic: BN6PR02MB2260:
X-Microsoft-Antispam-PRVS: <BN6PR02MB22602C174EA1CBBD3C0F0493A1849@BN6PR02MB2260.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /g6a79w9v6DqYvD/8N91O5JAn1EBOU7xWCp2hWWzGbVdNp8T8bPQFULcYWeX1o9yDVqM/e2AyIFU+2x9GpAd2lJsJZ6kq7cMgqDvjnN1YJUz4lrdPXqDEGCa91Rab0pL+q96YnEl+4GqVkdUS/XZQ/P5SDTqjrv3CsPWTiWOrby6CU8ybI7hDL+YfPXbpXqmU8PcElEDAB13XkQLHumqDYJONCJdgHm1Ny5qpb+AnPBszNKsunNuzSBFCYh/a7F6ZIgSMZ//Ay0meM++A2HR0Y35geDKG9SyOr9OYLzeDZ4fRZ11ER8+PrddQ4XBW10KmUP92EYNTJEuYAVJY0otukBg5jt6fuO1ZeqXqUp1Z1nIA9wOcAiH2Z+vsLrt1NTjJGEowDWvfdMQENpOt6QeXlh+UrUocIfHO6Nm9KfLypWFvvEjU3acg44wfIFzK/Lo/2bY/z8ZTJ0AgNUOB3MWq674AHqffbelpoXjdcg8SGI3r9iCIF1wYW8V7gvp2mrf/2BvYy+ehxVSsCth0xdXb5klQ97RZF7oYd7a1Un8jwXpBjLUb9iWToDn14JtMyIKmLoEZ7H08Q9fpyuXu5NzKdzbxaNr5VehWvyNINzrfBm57ixnQH5Qtb66GFd0rxig0d/mgRStLw3Sx5m2a+tU1j/wEP7wpaQ7DxwJAUeQCKHl55433ORhnAL+y58nXvj7Ksz4vkxFc5YButNs1OZBl1qmoWV1Lwembm6X8pfii3MLsV8N7De6A7D0KRfbpQXXtTsua28zSkuWznyU+dk272zWfLK90Of1YZtr7HOoGtKV2MzxklzvuUeXUrFR5V/N
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(376002)(346002)(46966006)(36840700001)(110136005)(478600001)(8936002)(316002)(82740400003)(7636003)(36756003)(82310400003)(2906002)(356005)(4326008)(30864003)(9786002)(31696002)(70586007)(83380400001)(44832011)(36860700001)(54906003)(31686004)(186003)(426003)(26005)(36906005)(5660300002)(8676002)(70206006)(47076005)(2616005)(53546011)(966005)(336012)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2021 05:15:46.1338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb773b5-0ce5-4870-4c5f-08d8d49569ba
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2260
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 02/18/2021 05:52 AM, Tom Rix wrote:
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> Hello,
>>
>> This is V3 of patch series which adds management physical function driver for Xilinx
>> Alveo PCIe accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
>> This driver is part of Xilinx Runtime (XRT) open source stack.
>>
>> XILINX ALVEO PLATFORM ARCHITECTURE
> Thanks for refreshing this patchset.
>
> It will take me a while to do the full review, so I thought I would give some early feed back.
>
> It applies to char-misc-next, but will have conflicts with in-flight patches around the MAINTAINERS file. This is not a big deal.
>
> The checkpatch is much better over v2, the complaints are
>
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #21:
> new file mode 100644
>
> WARNING: From:/Signed-off-by: email address mismatch: 'From: Lizhi Hou <lizhi.hou@xilinx.com>' != 'Signed-off-by: Lizhi Hou <lizhih@xilinx.com>'
>
> MAINTAINERS warning i believe you address in the last patch.
>
> In the next revisions, please fix the signoff.
>
> The test robot is complaining about hppa64.  While it may be an unlikely config, it would be best to fix it.
Thanks for reviewing. I will fix signoff, hppa64 and arm build issue 
reported by robot in next revision.
>
> Tom
>
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

