Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215292CE70D
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Dec 2020 05:41:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgLDElR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Dec 2020 23:41:17 -0500
Received: from mail-bn7nam10on2074.outbound.protection.outlook.com ([40.107.92.74]:24897
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbgLDElR (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 3 Dec 2020 23:41:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhpJDkNQNRbEc5ulXtMDvgZEmL0o/VAmuGsSnCL4L/JBecmBq/IvM1DfG8rv4O3qQKzS8t0YlnN77Y7EGFrpdV/kpqeUlGCb465QZugVSTOtBcF/HwDk7lCyyu96fRhhFfzKgME4e8aqyWmVpiSpn2PCQL/ohU4RbDOgp8cDkCemDI2HVi3JmrRfBOH2b4EdpXTgNOAhlCjmbiWYKkudy/nRRBp7QaJ19uEVzR6cm9ZcC6uDUP03qzCMti8B7GHgNX+PPLQABuxTIbhHia5T5RzxlVUqhhaPHQLXjxg3AITT5vJEboQS1/V8Mb47Qmavuk+6i6f629r/Ny2PeFT+/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99e+1kIY0lqXpP5k3v5v01DfC9cyEIMurmP1Y+hdnRU=;
 b=Fx0f1yGRhzjR8Tng8uBqj4clOyopufND+lRgyGeRwh7d8FHAaLJRSTSf8C6r2FxiEoyuJxAxdMxdb+AQRPk/pkD4FRaj9gNNPD3od+K8PDDZ4ig+X6O8QKFCF5EcWSWhCSuJxt7cjqIv1W4j/0+vrDuhgr+gEHpm4vnVsxrmAEZ4Oq1n0vqTzuaLVmZIsJHYnH4pJw8BZYkfmJ+cqZ4aOCQlQ7s/G/XJp7qHwXZ0H4bb5l4Lizu5AT8Q341VtJVzhc0URqszbERa1bukjxdK7/WhiDqGn+2u1nFexDCovPwz28SRcQQv3PGl4SE4sJmbrHwZdgHDz1tdexXsVcF35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99e+1kIY0lqXpP5k3v5v01DfC9cyEIMurmP1Y+hdnRU=;
 b=noN9Fk/BmUbpFBHXi8N/F2ZWWGL+391XNHbWrEad3Et+l84nuSUs3brmLNmCqqzfJiQwT/lf22cp3HbWWqsMkMTG9uiR6j3HVm5B/FA7xnT2J113JSobBvBDSE4wDK/PvrbJUlt3RPW8q9beuPvetMDybSTj/fUfNerBwN+T1vc=
Received: from MN2PR20CA0028.namprd20.prod.outlook.com (2603:10b6:208:e8::41)
 by MN2PR02MB6192.namprd02.prod.outlook.com (2603:10b6:208:181::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.19; Fri, 4 Dec
 2020 04:40:23 +0000
Received: from BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:e8:cafe::77) by MN2PR20CA0028.outlook.office365.com
 (2603:10b6:208:e8::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Fri, 4 Dec 2020 04:40:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT039.mail.protection.outlook.com (10.152.77.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.21 via Frontend Transport; Fri, 4 Dec 2020 04:40:22 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 3 Dec 2020 20:40:21 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 3 Dec 2020 20:40:21 -0800
Envelope-to: michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 stefanos@xilinx.com,
 lizhih@xilinx.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 yilun.xu@intel.com
Received: from [10.17.3.3] (port=58406)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <max.zhen@xilinx.com>)
        id 1kl2tJ-0005zl-5e; Thu, 03 Dec 2020 20:40:21 -0800
Subject: Re: [PATCH Xilinx Alveo 7/8] fpga: xrt: Alveo management physical
 function driver
To:     Xu Yilun <yilun.xu@intel.com>,
        Sonal Santan <sonal.santan@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <lizhih@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>
References: <20201129000040.24777-1-sonals@xilinx.com>
 <20201129000040.24777-8-sonals@xilinx.com>
 <20201202030026.GD22103@yilunxu-OptiPlex-7050>
From:   Max Zhen <max.zhen@xilinx.com>
Message-ID: <84c896d1-1e61-fbec-df22-72fe061f39e3@xilinx.com>
Date:   Thu, 3 Dec 2020 20:40:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20201202030026.GD22103@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b25149b-8fba-43d4-4bf3-08d8980eb677
X-MS-TrafficTypeDiagnostic: MN2PR02MB6192:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6192546907497AC5DE340DF8B9F10@MN2PR02MB6192.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dex7mHiH2ML6jzB7tD0i8l1EV5lHOM3jsX205b57qP+1FfPA+xSHEyGUEdhShVoFB0AVP5+a5xEPyxc7E1dgQPdc4xfs2N5UhF5YEAfZZmBcDYHlB0VBpcd804btE4J9AVOJ6zVeMw+iikNGJ99GXP8TkbG+tSJoGh8HLtBKHKVNkGeJ0lgcCxTTx6V5o2+TZKTpcW8OhMkZNRJSE4IW+X9Qnw9+ejhFqELHhaUu7ClFxFRdZiLfwqanEUHH2ZrnnPTDsKZGRVXq3atsocOt1dc33W3KfxHeiLnEgIw+YNVMhMQi5u/GHBdC0JLRFUXU3KwpOTYqGLOF0nkdZO7d1dC8EBCnEPdsPR1tWhp5hSDkzIFajyUCPqVjAk2BC4g3uYHRgnv9hP2De0MqVNVCAAuJWNtLTzDfXv2KDkULf1Ih3qieWRFCF4v+Rp2AI/s7bsRc3fo5t9NKChpSPgzeaw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(36906005)(186003)(6636002)(7636003)(31686004)(356005)(47076004)(31696002)(26005)(82740400003)(478600001)(2616005)(8936002)(4326008)(426003)(70206006)(70586007)(110136005)(5660300002)(44832011)(54906003)(316002)(336012)(9786002)(36756003)(53546011)(82310400003)(8676002)(2906002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 04:40:22.9751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b25149b-8fba-43d4-4bf3-08d8980eb677
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT039.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6192
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Yilun,


On 12/1/20 7:00 PM, Xu Yilun wrote:
> 
> 
>> +static int xmgmt_main_event_cb(struct platform_device *pdev,
>> +     enum xrt_events evt, void *arg)
>> +{
>> +     struct xmgmt_main *xmm = platform_get_drvdata(pdev);
>> +     struct xrt_event_arg_subdev *esd = (struct xrt_event_arg_subdev *)arg;
>> +     enum xrt_subdev_id id;
>> +     int instance;
>> +     size_t fwlen;
>> +
>> +     switch (evt) {
>> +     case XRT_EVENT_POST_CREATION: {
>> +             id = esd->xevt_subdev_id;
>> +             instance = esd->xevt_subdev_instance;
>> +             xrt_info(pdev, "processing event %d for (%d, %d)",
>> +                     evt, id, instance);
>> +
>> +             if (id == XRT_SUBDEV_GPIO)
>> +                     xmm->gpio_ready = true;
>> +             else if (id == XRT_SUBDEV_QSPI)
>> +                     xmm->flash_ready = true;
>> +             else
>> +                     BUG_ON(1);
>> +
>> +             if (xmm->gpio_ready && xmm->flash_ready) {
>> +                     int rc;
>> +
>> +                     rc = load_firmware_from_disk(pdev, &xmm->firmware_blp,
>> +                             &fwlen);
>> +                     if (rc != 0) {
>> +                             rc = load_firmware_from_flash(pdev,
>> +                                     &xmm->firmware_blp, &fwlen);
> 
> I'm curious that before the shell metadata is loaded, how the QSPI
> subdev is enumerated and get to work? The QSPI DT info itself is
> stored in metadata, is it?

No, it is not from the shell metadata. The QSPI subdev info is 
discovered from a rom located on the PCIE BAR pointed to by VSEC cap 
found in config space.

> 
> I didn't find the creation of leaf platform devices, maybe I can find
> the answer in the missing Patch #5?

Leaf driver is children of partition driver. They are created in 
xrt_part_create_leaves() in xrt-partition.c.

Thanks,
Max

> 
> Thanks,
> Yilun
> 
>> +                     }
>> +                     if (rc == 0 && is_valid_firmware(pdev,
>> +                         xmm->firmware_blp, fwlen))
>> +                             (void) xmgmt_create_blp(xmm);
>> +                     else
>> +                             xrt_err(pdev,
>> +                                     "failed to find firmware, giving up");
>> +                     xmm->evt_hdl = NULL;
>> +             }
>> +             break;
>> +     }
