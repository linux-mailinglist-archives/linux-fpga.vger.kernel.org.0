Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6090C3CF044
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Jul 2021 01:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbhGSXLh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Jul 2021 19:11:37 -0400
Received: from mail-dm6nam10on2080.outbound.protection.outlook.com ([40.107.93.80]:55904
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1388044AbhGSUm3 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Jul 2021 16:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9S5AaiU51JlKffYSArFp7DiuaXqda/iuooRW0onCIo9j3hSr5aW8DRgiBkG4OiHNUMz+x4WNe3aWD928DL12/J1OKwjj5caWWrXgCDAxEa2gcZvRRB6WEUdQoDz1lgY+QmUIAkEuiBzUO2iKAGGjVF/P9yyRnLn47NYDY8DeSZhHI4qvPWQFYtSQ3luO3BvLqMRsmV/aLYmTIWG94euwdQL8D2IkmMswP0r3z7nDx4+M473J9XxkC8dD1HZJl6ab3rN1XpUIvXjAG1Ure1tWUsMKkvqBNiszv++c/dSOlb4Wbvg7O7HiSFDotBKfC3MvS7rjLN34KmCbpa89u0ySg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNHitPp+R64nKFTNsPKVhyw5i79DxU19QWXIu4NuuiM=;
 b=ILJHElFY3w2zX1VvCScw3BqWolOkooVwP6LChysx9rtfxxSQBYn/I/PJQ+MKSuJFbZW2Cb3r4EV+LuLckILYJlcwFX4MMnF2OV8VndD4UhLPpenAxBw1twdCL9L4pyrCQCFuJPgijQOUO+3xPrYHtjhKRkXiX6fWMkB6T943IDULgGb/yKWsLoUe1NAgXjX5nOVHEbYajiF5kcxlYd9kSnOSEFMPRPf5DGAS6apuG2ndjZMTPlwdO4Y8TFHJrQiGlEdALim/JHagCjuJDnO8PGYk67v+D5YVb63UHT/hjR2PLY7xf6sEaTWry8iw19+db5CM8vJ4CfDQxPDKOE7HLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNHitPp+R64nKFTNsPKVhyw5i79DxU19QWXIu4NuuiM=;
 b=DKPeHmhivDTO7rNy218bxGc0gN1PTdZYBtB0o60I6dxU7YSO3sbgWe4Hl1d9ASIleNH8J5vjROtv4ADyeZr180hkJkVxp+SDJYzM4ZGz4vnmulLK3QITtOm6+PqRa1m725HLRuaJyL5LyQJ6HEqsACx88jouixMVrKU3YwxYbx0=
Received: from SN7PR04CA0005.namprd04.prod.outlook.com (2603:10b6:806:f2::10)
 by DM6PR02MB4330.namprd02.prod.outlook.com (2603:10b6:5:2a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.30; Mon, 19 Jul
 2021 21:22:22 +0000
Received: from SN1NAM02FT0028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:f2:cafe::33) by SN7PR04CA0005.outlook.office365.com
 (2603:10b6:806:f2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Mon, 19 Jul 2021 21:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0028.mail.protection.outlook.com (10.97.4.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 21:22:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 14:22:20 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 19 Jul 2021 14:22:20 -0700
Envelope-to: robh@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 mdf@kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=59566)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1m5aiS-000EsZ-Sl; Mon, 19 Jul 2021 14:22:20 -0700
Subject: Re: [PATCH V7 XRT Alveo 00/20] XRT Alveo driver overview
To:     Tom Rix <trix@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mdf@kernel.org" <mdf@kernel.org>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        Max Zhen <maxz@xilinx.com>, Sonal Santan <sonals@xilinx.com>,
        Yu Liu <yliu@xilinx.com>, Michal Simek <michals@xilinx.com>,
        Stefano Stabellini <stefanos@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
 <0677c3b8-87a8-7092-0c63-36de55a4de4d@redhat.com>
 <7290da0c-0e6f-81e3-e1b8-087536110569@redhat.com>
 <66B9450C-056E-4B2D-85B8-CBAC1D820EAA@xilinx.com>
 <4ba4479f-190b-c118-a39a-6d93edd2f455@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <5bedea0d-be48-27ee-4091-3231edc86f4e@xilinx.com>
Date:   Mon, 19 Jul 2021 14:22:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <4ba4479f-190b-c118-a39a-6d93edd2f455@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6ced7aec-a6c9-43cc-fa6d-08d94afb4c2b
X-MS-TrafficTypeDiagnostic: DM6PR02MB4330:
X-Microsoft-Antispam-PRVS: <DM6PR02MB43303063079EBAD0C8B91699A1E19@DM6PR02MB4330.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RaqsvS94dnx6llpwZ/kv+q0uB/c4xesEQZ8dL1Y78ZYEP8BSAPyfT9iyeKIXxeLpojhhGwEir2P7+aX/dLFwQthQIsq4sBSC46XXwNSgGUD55vhh+FZbPksOzzxulaCFlt3ieOuJwwgZ+on6Ggd0CRMJ0wKvVQbedr4UsHiR38zXh0CmR359BDw1cmb07QW/XB7wqmW+gY+6MuFgL4VsKnx0bEY5BurNe6H6xNiV25oRh3Pn0jJEiJz10gEDwF37h8499lnaQ7kPhVJ8rLIVZcmVuwE4y6xEBv5VwUUynUwOYuSGzU8ngNG7w69sFB2uAj/6uver0ThSBlHYMaGJYqgdYtovbrhgHg8aVPYBrJLfu7G10jjLCrdnDwShA+moBBCrcAoRCdV3J6cb6a5R7WmfFe687pBBhcgxNFoOlUg+6h2mbk2aBnv7AU9J9UYiGRItmwZDp3YojF8mrsGsXoBRx+jfcOcZxPuFJMP48btXyvMRgKh5TFzDJN56uAlU0VdX6HfO62Z//q78VEqu56kNOixG837ApPaspDNdDWXP6D7ag7Yk8EEXUStWqW7kmyz6oC+/7y3XhXTgEjow9Kd/v2MWGNqJ2hE/9X55OE0uKhypEzXTJvp/NUPZZk4tjx0+8knTVtLvTxm8YgTOKroNKrasksIocp8MQ6AZzXzJYagBjQmCpdR0FgbEKLYwef0HSkxT9mla8UGFLe/wddIV2UC5AoSmx1UIVjFrJfL6CglzQEWydWlDPXpIQOBolUNuiozqQb/DuXhnyG7e8NFWV6nz3sTfjZcxFizMCNfPm7xmiUnc2/uUSnyogZmyJohg+Vu0sfE8ncvavqxA+4bZYF+Ncal4NhDLriXS18P+PBCeJxtRJH4QwHjxU9Pc
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(9786002)(316002)(36906005)(36756003)(31696002)(8676002)(8936002)(54906003)(186003)(26005)(110136005)(53546011)(2616005)(30864003)(966005)(4326008)(83380400001)(336012)(5660300002)(82310400003)(36860700001)(44832011)(478600001)(2906002)(356005)(31686004)(7636003)(426003)(82740400003)(70206006)(70586007)(47076005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 21:22:22.4023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ced7aec-a6c9-43cc-fa6d-08d94afb4c2b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4330
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,

Sure. I will send out a V8 set just dropping listed xleafs and doing the 
cleanups.

Thanks,

Lizhi


On 07/16/2021 01:36 PM, Tom Rix wrote:
> CAUTION: This message has originated from an External Source. Please 
> use proper judgment and caution when opening attachments, clicking 
> links, or responding to this email.
>
>
> On 7/16/21 12:14 PM, Lizhi Hou wrote:
>> Hi Tom,
>>
>> I am working on v8 patchset which I followed your guidance to move 
>> the listed xleaf to suggested subsystems. And the spelling error 
>> fixes, and fpga-xrt.h cleanup are all included.
>> Does that make senses to you? If yes, I may send the V8 patchset 
>> early next week for you to review.
>
> Can handling the move be done in a followup ?
>
> AFAIK, there are no other problems with v7 and I would rather see a
> smaller subset of v7 make it intree sooner.
>
> This would mean dropping the (maybe) contentious xleafs from v8 just
> doing the cleanups.
>
> Tom
>
>>
>> Thanks,
>> Lizhi
>>
>> ﻿On 7/16/21, 11:27 AM, "Tom Rix" <trix@redhat.com> wrote:
>>
>>      CAUTION: This message has originated from an External Source. 
>> Please use proper judgment and caution when opening attachments, 
>> clicking links, or responding to this email.
>>
>>
>>      On 7/1/21 1:32 PM, Tom Rix wrote:
>>      > Lizhi,
>>      >
>>      > Sorry for the delay in reviewing v7.
>>      >
>>      > Is it too early to blame it on the July 4 holiday here ?!? :)
>>      >
>>      >
>>      > All the small stuff looks fine to me.  In this pass I looked 
>> at issues
>>      > that would need a refactoring.  Since it would be a lot of 
>> work and I
>>      > am not the final word on this, it would be good if some others to
>>      > chime in. Also a couple of new spelling fixes at the end.
>>
>>      Lizhi
>>
>>      This pathset has stalled.
>>
>>      The spelling changes should be fixed.
>>
>>      Some of xleafs may need to be moved and reworked.
>>
>>      The addition of building outside of fpga/xrt is a new feature, 
>> and I
>>      think is best considered when the first foundational change (this
>>      patchset) is in tree.
>>
>>      Could the xleafs' below be dropped from this set ?
>>
>>      Tom
>>
>>      >
>>      > Tom
>>      >
>>      >
>>      > Having xrt/ dir
>>      > ok with it or it will follow the subdir reorg of fpga/, afaik 
>> not a
>>      > blocker
>>      >
>>      > Location of xrt_bus_type
>>      > ok, similar to dfl_bus_type
>>      >
>>      > Non fpga subdevices should go to other subsystems.
>>      > looking in drivers/fpga/xrt/lib/xleaf
>>      >
>>      > clock clkfrq ucs these are clocks
>>      > should move to drivers/clk/xilinx/
>>      >
>>      > axigate, for fpga partitioning
>>      > ok to stay
>>      >
>>      > ddr_calibaration, a memory status checker
>>      > should move drivers/memory dfl-emif is similar
>>      >
>>      > devctl, a general purpose misc driver
>>      > should move to drivers/mfd
>>      >
>>      > icap, for fpga bitstream writing
>>      > ok to stay
>>      >
>>      > vsec, misc small drivers discovered via pci config vsec
>>      > should move to drivers/mfd
>>      >
>>      > For include/uapi/linux
>>      > collapse include/uapi/linux/xrt/*.h into 
>> include/uapi/linux/fpga-xrt.h
>>      > There are only 2 files, one really small. fpga-xrt.h follows 
>> fpga-dfl.h
>>      > The comments are pretty messy, user should be able to scan them.
>>      > Try cleaning them up.
>>      >
>>      > Spelling mistakes
>>      >
>>      > diff --git a/Documentation/fpga/xrt.rst 
>> b/Documentation/fpga/xrt.rst
>>      > index 5a5b4d5a3bc6..84eb41be9ac1 100644
>>      > --- a/Documentation/fpga/xrt.rst
>>      > +++ b/Documentation/fpga/xrt.rst
>>      > @@ -275,7 +275,7 @@ fpga_bridge and fpga_region for the next 
>> region in
>>      > the chain.
>>      >  fpga_bridge
>>      >  -----------
>>      >
>>      > -Like the fpga_region, a fpga_bridge is created by walking the 
>> device
>>      > tree
>>      > +Like the fpga_region, an fpga_bridge is created by walking 
>> the device
>>      > tree
>>      >  of the parent group. The bridge is used for isolation between a
>>      > parent and
>>      >  its child.
>>      >
>>      > @@ -416,7 +416,7 @@ xclbin is compiled by end user using
>>      >  `Vitis
>>      > 
>> <https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html>`_
>>      >  tool set from Xilinx. The xclbin contains sections describing 
>> user
>>      > compiled
>>      >  acceleration engines/kernels, memory subsystems, clocking 
>> information
>>      > etc. It also
>>      > -contains a FPGA bitstream for the user partition, UUIDs, 
>> platform
>>      > name, etc.
>>      > +contains an FPGA bitstream for the user partition, UUIDs, 
>> platform
>>      > name, etc.
>>      >
>>      >
>>      >  .. _xsabin_xclbin_container_format:
>>      > diff --git a/drivers/fpga/xrt/include/metadata.h
>>      > b/drivers/fpga/xrt/include/metadata.h
>>      > index c4df88262f8a..f48d6d42f5ef 100644
>>      > --- a/drivers/fpga/xrt/include/metadata.h
>>      > +++ b/drivers/fpga/xrt/include/metadata.h
>>      > @@ -194,7 +194,7 @@ int xrt_md_get_interface_uuids(struct 
>> device *dev,
>>      > const char *blob,
>>      >  /*
>>      >   * The firmware provides a 128 bit hash string as a unique id 
>> to the
>>      >   * partition/interface.
>>      > - * Existing hw does not yet use the cononical form, so it is
>>      > necessary to
>>      > + * Existing hw does not yet use the canonical form, so it is
>>      > necessary to
>>      >   * use a translation function.
>>      >   */
>>      >  static inline void xrt_md_trans_uuid2str(const uuid_t *uuid, 
>> char
>>      > *uuidstr)
>>      > diff --git a/drivers/fpga/xrt/lib/xroot.c 
>> b/drivers/fpga/xrt/lib/xroot.c
>>      > index 7b3e540dd6c0..f324a25e1d4d 100644
>>      > --- a/drivers/fpga/xrt/lib/xroot.c
>>      > +++ b/drivers/fpga/xrt/lib/xroot.c
>>      > @@ -427,7 +427,7 @@ static void xroot_bringup_group_work(struct
>>      > work_struct *work)
>>      >                 r = xleaf_call(xdev, XRT_GROUP_INIT_CHILDREN, 
>> NULL);
>>      >                 xroot_put_group(xr, xdev);
>>      >                 if (r == -EEXIST)
>>      > -                       continue; /* Already brough up, 
>> nothing to do. */
>>      > +                       continue; /* Already brought up, 
>> nothing to
>>      > do. */
>>      >                 if (r)
>>      > atomic_inc(&xr->groups.bringup_failed_cnt);
>>      >
>>      > diff --git a/drivers/fpga/xrt/mgmt/xmgmt-main.c
>>      > b/drivers/fpga/xrt/mgmt/xmgmt-main.c
>>      > index 820c888e7918..9077254e0f8a 100644
>>      > --- a/drivers/fpga/xrt/mgmt/xmgmt-main.c
>>      > +++ b/drivers/fpga/xrt/mgmt/xmgmt-main.c
>>      > @@ -142,7 +142,7 @@ static ssize_t VBNV_show(struct device *dev,
>>      > struct device_attribute *da, char *
>>      >  }
>>      >  static DEVICE_ATTR_RO(VBNV);
>>      >
>>      > -/* logic uuid is the uuid uniquely identfy the partition */
>>      > +/* logic uuid is the uuid uniquely identify the partition */
>>      >  static ssize_t logic_uuids_show(struct device *dev, struct
>>      > device_attribute *da, char *buf)
>>      >  {
>>      >         struct xrt_device *xdev = to_xrt_dev(dev);
>>      > diff --git a/drivers/fpga/xrt/mgmt/xrt-mgr.c
>>      > b/drivers/fpga/xrt/mgmt/xrt-mgr.c
>>      > index 41263a033d9d..ab253b516e8d 100644
>>      > --- a/drivers/fpga/xrt/mgmt/xrt-mgr.c
>>      > +++ b/drivers/fpga/xrt/mgmt/xrt-mgr.c
>>      > @@ -115,7 +115,7 @@ static int xmgmt_pr_write_init(struct 
>> fpga_manager
>>      > *mgr,
>>      >  }
>>      >
>>      >  /*
>>      > - * The implementation requries full xclbin image before we 
>> can start
>>      > + * The implementation requires full xclbin image before we 
>> can start
>>      >   * programming the hardware via ICAP subsystem. The full 
>> image is
>>      > required
>>      >   * for checking the validity of xclbin and walking the 
>> sections to
>>      >   * discover the bitstream.
>>      >
>>      > On 5/27/21 5:49 PM, Lizhi Hou wrote:
>>      >> Hello,
>>      >>
>>      >> This is V7 of patch series which adds management physical 
>> function
>>      >> driver
>>      >> for Xilinx Alveo PCIe accelerator cards.
>>      >> https://www.xilinx.com/products/boards-and-kits/alveo.html
>>      >>
>>      >> This driver is part of Xilinx Runtime (XRT) open source stack.
>>      >>
>>      >> XILINX ALVEO PLATFORM ARCHITECTURE
>>      >>
>>      >> Alveo PCIe FPGA based platforms have a static *shell* 
>> partition and a
>>      >> partial re-configurable *user* partition. The shell partition is
>>      >> automatically loaded from flash when host is booted and PCIe is
>>      >> enumerated
>>      >> by BIOS. Shell cannot be changed till the next cold reboot. 
>> The shell
>>      >> exposes two PCIe physical functions:
>>      >>
>>      >> 1. management physical function
>>      >> 2. user physical function
>>      >>
>>      >> The patch series includes Documentation/xrt.rst which 
>> describes Alveo
>>      >> platform, XRT driver architecture and deployment model in 
>> more detail.
>>      >>
>>      >> Users compile their high level design in C/C++/OpenCL or RTL 
>> into FPGA
>>      >> image using Vitis tools.
>>      >> 
>> https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
>>      >>
>>      >> The compiled image is packaged as xclbin which contains partial
>>      >> bitstream
>>      >> for the user partition and necessary metadata. Users can 
>> dynamically
>>      >> swap
>>      >> the image running on the user partition in order to switch 
>> between
>>      >> different workloads by loading different xclbins.
>>      >>
>>      >> XRT DRIVERS FOR XILINX ALVEO
>>      >>
>>      >> XRT Linux kernel driver *xrt-mgmt* binds to management physical
>>      >> function of
>>      >> Alveo platform. The modular driver framework is organized 
>> into several
>>      >> platform drivers which primarily handle the following 
>> functionality:
>>      >>
>>      >> 1.  Loading firmware container also called xsabin at driver 
>> attach time
>>      >> 2.  Loading of user compiled xclbin with FPGA Manager 
>> integration
>>      >> 3.  Clock scaling of image running on user partition
>>      >> 4.  In-band sensors: temp, voltage, power, etc.
>>      >> 5.  Device reset and rescan
>>      >>
>>      >> The platform drivers are packaged into *xrt-lib* helper 
>> module with well
>>      >> defined interfaces. The module provides a pseudo-bus 
>> implementation
>>      >> for the
>>      >> platform drivers. More details on the driver model can be 
>> found in
>>      >> Documentation/xrt.rst.
>>      >>
>>      >> User physical function driver is not included in this patch 
>> series.
>>      >>
>>      >> LIBFDT REQUIREMENT
>>      >>
>>      >> XRT driver infrastructure uses Device Tree as a metadata 
>> format to
>>      >> discover
>>      >> HW subsystems in the Alveo PCIe device. The Device Tree 
>> schema used
>>      >> by XRT
>>      >> is documented in Documentation/xrt.rst.
>>      >>
>>      >> TESTING AND VALIDATION
>>      >>
>>      >> xrt-mgmt driver can be tested with full XRT open source stack 
>> which
>>      >> includes user space libraries, board utilities and (out of 
>> tree) first
>>      >> generation user physical function driver xocl. XRT open 
>> source runtime
>>      >> stack is available at https://github.com/Xilinx/XRT
>>      >>
>>      >> Complete documentation for XRT open source stack including 
>> sections on
>>      >> Alveo/XRT security and platform architecture can be found here:
>>      >>
>>      >> https://xilinx.github.io/XRT/master/html/index.html
>>      >> https://xilinx.github.io/XRT/master/html/security.html
>>      >> 
>> https://xilinx.github.io/XRT/master/html/platforms_partitions.html
>>      >>
>>      >> Changes since v6:
>>      >> - Resolved grammatical errors and cleaned up taxonomy in xrt.rst
>>      >>    documentation.
>>      >> - Fixed clang warnings.
>>      >> - Updated code base to include v6 code review comments.
>>      >>
>>      >> Changes since v5:
>>      >> - Revert all changes 'mgnt/MGNT' back to 'mgmt/MGMT'
>>      >> - Updated code base to include v5 code review comments.
>>      >>     xrt.rst: address grammar and taxonomy
>>      >>     subdev_id.h: defines XRT_SUBDEV_INVALID = 0
>>      >>     xclbin.c: change shift operation to be_to_cpu
>>      >> - Resolved kernel test robot errors.
>>      >>
>>      >> Changes since v4:
>>      >> - Added xrt_bus_type and xrt_device. All sub devices were 
>> changed from
>>      >>    platform_bus_type/platform_device to xrt_bus_type/xrt_device.
>>      >> - Renamed xrt-mgmt driver to xrt-mgnt driver.
>>      >> - Replaced 'MGMT' with 'MGNT' and 'mgmt' with 'mgnt' in code 
>> and file
>>      >> names
>>      >> - Moved pci function calls from infrastructure to xrt-mgnt 
>> driver.
>>      >> - Renamed files: mgmt/main.c -> mgnt/xmgnt-main.c
>>      >>                   mgmt/main-region.c -> mgnt/xmgnt-main-region.c
>>      >>                   include/xmgmt-main.h -> include/xmgnt-main.h
>>      >>                   mgmt/fmgr-drv.c -> mgnt/xrt-mgr.c
>>      >>                   mgmt/fmgr.h -> mgnt/xrt-mgr.h
>>      >> - Updated code base to include v4 code review comments.
>>      >>
>>      >> Changes since v3:
>>      >> - Leaf drivers use regmap-mmio to access hardware registers.
>>      >> - Renamed driver module: xmgmt.ko -> xrt-mgmt.ko
>>      >> - Renamed files: calib.[c|h] -> ddr_calibration.[c|h],
>>      >>                   lib/main.[c|h] -> lib/lib-drv.[c|h],
>>      >>                   mgmt/main-impl.h - > mgmt/xmgnt.h
>>      >> - Updated code base to include v3 code review comments.
>>      >>
>>      >> Changes since v2:
>>      >> - Streamlined the driver framework into *xleaf*, *group* and 
>> *xroot*
>>      >> - Updated documentation to show the driver model with examples
>>      >> - Addressed kernel test robot errors
>>      >> - Added a selftest for basic driver framework
>>      >> - Documented device tree schema
>>      >> - Removed need to export libfdt symbols
>>      >>
>>      >> Changes since v1:
>>      >> - Updated the driver to use fpga_region and fpga_bridge for FPGA
>>      >>    programming
>>      >> - Dropped platform drivers not related to PR programming to 
>> focus on XRT
>>      >>    core framework
>>      >> - Updated Documentation/fpga/xrt.rst with information on XRT 
>> core
>>      >> framework
>>      >> - Addressed checkpatch issues
>>      >> - Dropped xrt- prefix from some header files
>>      >>
>>      >> For reference V6 version of patch series can be found here:
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-1-lizhi.hou@xilinx.com/
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-2-lizhi.hou@xilinx.com/
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-3-lizhi.hou@xilinx.com/
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-4-lizhi.hou@xilinx.com/
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-5-lizhi.hou@xilinx.com/
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-6-lizhi.hou@xilinx.com/
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-7-lizhi.hou@xilinx.com/
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-8-lizhi.hou@xilinx.com/
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-9-lizhi.hou@xilinx.com/
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-10-lizhi.hou@xilinx.com/
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-11-lizhi.hou@xilinx.com/
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-12-lizhi.hou@xilinx.com/
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-13-lizhi.hou@xilinx.com/
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-14-lizhi.hou@xilinx.com/
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-15-lizhi.hou@xilinx.com/
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-16-lizhi.hou@xilinx.com/
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-17-lizhi.hou@xilinx.com/
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-18-lizhi.hou@xilinx.com/
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-19-lizhi.hou@xilinx.com/
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-20-lizhi.hou@xilinx.com/
>>      >>
>>      >> 
>> https://lore.kernel.org/lkml/20210512015339.5649-21-lizhi.hou@xilinx.com/
>>      >>
>>      >>
>>      >> Lizhi Hou (20):
>>      >>    Documentation: fpga: Add a document describing XRT Alveo 
>> drivers
>>      >>    fpga: xrt: driver metadata helper functions
>>      >>    fpga: xrt: xclbin file helper functions
>>      >>    fpga: xrt: xrt-lib driver manager
>>      >>    fpga: xrt: group driver
>>      >>    fpga: xrt: char dev node helper functions
>>      >>    fpga: xrt: root driver infrastructure
>>      >>    fpga: xrt: driver infrastructure
>>      >>    fpga: xrt: management physical function driver (root)
>>      >>    fpga: xrt: main driver for management function device
>>      >>    fpga: xrt: fpga-mgr and region implementation for xclbin 
>> download
>>      >>    fpga: xrt: VSEC driver
>>      >>    fpga: xrt: User Clock Subsystem driver
>>      >>    fpga: xrt: ICAP driver
>>      >>    fpga: xrt: devctl xrt driver
>>      >>    fpga: xrt: clock driver
>>      >>    fpga: xrt: clock frequency counter driver
>>      >>    fpga: xrt: DDR calibration driver
>>      >>    fpga: xrt: partition isolation driver
>>      >>    fpga: xrt: Kconfig and Makefile updates for XRT drivers
>>      >>
>>      >>   Documentation/fpga/index.rst |   1 +
>>      >>   Documentation/fpga/xrt.rst                    | 870 
>> ++++++++++++++++++
>>      >>   MAINTAINERS                                   | 11 +
>>      >>   drivers/Makefile |   1 +
>>      >>   drivers/fpga/Kconfig |   2 +
>>      >>   drivers/fpga/Makefile |   5 +
>>      >>   drivers/fpga/xrt/Kconfig |   8 +
>>      >>   drivers/fpga/xrt/include/events.h             | 45 +
>>      >>   drivers/fpga/xrt/include/group.h              | 25 +
>>      >>   drivers/fpga/xrt/include/metadata.h           | 236 +++++
>>      >>   drivers/fpga/xrt/include/subdev_id.h          | 39 +
>>      >>   drivers/fpga/xrt/include/xclbin-helper.h      | 48 +
>>      >>   drivers/fpga/xrt/include/xdevice.h            | 131 +++
>>      >>   drivers/fpga/xrt/include/xleaf.h              | 205 +++++
>>      >>   drivers/fpga/xrt/include/xleaf/axigate.h      | 23 +
>>      >>   drivers/fpga/xrt/include/xleaf/clkfreq.h      | 21 +
>>      >>   drivers/fpga/xrt/include/xleaf/clock.h        | 29 +
>>      >>   .../fpga/xrt/include/xleaf/ddr_calibration.h  | 28 +
>>      >>   drivers/fpga/xrt/include/xleaf/devctl.h       | 40 +
>>      >>   drivers/fpga/xrt/include/xleaf/icap.h         | 27 +
>>      >>   drivers/fpga/xrt/include/xmgmt-main.h         | 34 +
>>      >>   drivers/fpga/xrt/include/xroot.h              | 117 +++
>>      >>   drivers/fpga/xrt/lib/Kconfig                  | 17 +
>>      >>   drivers/fpga/xrt/lib/Makefile                 | 30 +
>>      >>   drivers/fpga/xrt/lib/cdev.c                   | 209 +++++
>>      >>   drivers/fpga/xrt/lib/group.c                  | 278 ++++++
>>      >>   drivers/fpga/xrt/lib/lib-drv.c                | 328 +++++++
>>      >>   drivers/fpga/xrt/lib/lib-drv.h                | 21 +
>>      >>   drivers/fpga/xrt/lib/subdev.c                 | 859 
>> +++++++++++++++++
>>      >>   drivers/fpga/xrt/lib/subdev_pool.h            | 53 ++
>>      >>   drivers/fpga/xrt/lib/xclbin.c                 | 381 ++++++++
>>      >>   drivers/fpga/xrt/lib/xleaf/axigate.c          | 325 +++++++
>>      >>   drivers/fpga/xrt/lib/xleaf/clkfreq.c          | 223 +++++
>>      >>   drivers/fpga/xrt/lib/xleaf/clock.c            | 652 
>> +++++++++++++
>>      >>   drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 210 +++++
>>      >>   drivers/fpga/xrt/lib/xleaf/devctl.c           | 169 ++++
>>      >>   drivers/fpga/xrt/lib/xleaf/icap.c             | 328 +++++++
>>      >>   drivers/fpga/xrt/lib/xleaf/ucs.c              | 152 +++
>>      >>   drivers/fpga/xrt/lib/xleaf/vsec.c             | 372 ++++++++
>>      >>   drivers/fpga/xrt/lib/xroot.c                  | 536 
>> +++++++++++
>>      >>   drivers/fpga/xrt/metadata/Kconfig             | 12 +
>>      >>   drivers/fpga/xrt/metadata/Makefile            | 16 +
>>      >>   drivers/fpga/xrt/metadata/metadata.c          | 578 
>> ++++++++++++
>>      >>   drivers/fpga/xrt/mgmt/Kconfig                 | 15 +
>>      >>   drivers/fpga/xrt/mgmt/Makefile                | 19 +
>>      >>   drivers/fpga/xrt/mgmt/root.c                  | 420 +++++++++
>>      >>   drivers/fpga/xrt/mgmt/xmgmt-main-region.c     | 483 ++++++++++
>>      >>   drivers/fpga/xrt/mgmt/xmgmt-main.c            | 662 
>> +++++++++++++
>>      >>   drivers/fpga/xrt/mgmt/xmgmt.h                 | 33 +
>>      >>   drivers/fpga/xrt/mgmt/xrt-mgr.c               | 190 ++++
>>      >>   drivers/fpga/xrt/mgmt/xrt-mgr.h               | 16 +
>>      >>   include/uapi/linux/xrt/xclbin.h               | 409 ++++++++
>>      >>   include/uapi/linux/xrt/xmgmt-ioctl.h          | 46 +
>>      >>   53 files changed, 9988 insertions(+)
>>      >>   create mode 100644 Documentation/fpga/xrt.rst
>>      >>   create mode 100644 drivers/fpga/xrt/Kconfig
>>      >>   create mode 100644 drivers/fpga/xrt/include/events.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/group.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/metadata.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/xdevice.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
>>      >>   create mode 100644 
>> drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
>>      >>   create mode 100644 drivers/fpga/xrt/include/xroot.h
>>      >>   create mode 100644 drivers/fpga/xrt/lib/Kconfig
>>      >>   create mode 100644 drivers/fpga/xrt/lib/Makefile
>>      >>   create mode 100644 drivers/fpga/xrt/lib/cdev.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/group.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
>>      >>   create mode 100644 drivers/fpga/xrt/lib/subdev.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
>>      >>   create mode 100644 drivers/fpga/xrt/lib/xclbin.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c
>>      >>   create mode 100644 
>> drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>>      >>   create mode 100644 drivers/fpga/xrt/lib/xroot.c
>>      >>   create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>>      >>   create mode 100644 drivers/fpga/xrt/metadata/Makefile
>>      >>   create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>>      >>   create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>>      >>   create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>>      >>   create mode 100644 drivers/fpga/xrt/mgmt/root.c
>>      >>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main-region.c
>>      >>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main.c
>>      >>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt.h
>>      >>   create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.c
>>      >>   create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.h
>>      >>   create mode 100644 include/uapi/linux/xrt/xclbin.h
>>      >>   create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h
>>      >>
>>
>>
>

