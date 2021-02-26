Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C86E63269C4
	for <lists+linux-fpga@lfdr.de>; Fri, 26 Feb 2021 22:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbhBZV6S (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 26 Feb 2021 16:58:18 -0500
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:3553
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229698AbhBZV6R (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 26 Feb 2021 16:58:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l0apr8PA8lAzCG3aqVmXVIZvlOXD5yFJaGDX9Rex9q/pc4+gPYD5/8kclLJsFKez9lGV8UuzDXb25DYGMzRRBGnBHCpOM0dNn+uXyAv+omNycS5/vdn6NVlUARMI/HuAh1joldsCDjKj/H/VwKOjCIrz9pTqJ7dER/m/shSh9xBV96VCKptkalA0y/feocY1IVX0IrGC8E0SFLlKITTDKb+nE3gJpfL1/1Xzgb5eppliI6wd1utftusK2RvquxxwR20IRfOgUTlSKlwH5BVAct6DmqGIXKF2aYQxwcHWJ1Obm1FCc3VIHicwSFni+gjG6cTadP5biryZOKo85ABZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMKPgbZ82ovOX4ICOp+iMdZQe9vog8EzhccbYRDxyo0=;
 b=eq76pjWCXZbZA+IduH2ZEhMM+gU24PLWXUpQx0EG9XApq5fmuCFUV2A+LaZjp43mxAHWDHiJB6JetX7RutHMDVl1vUJLXeQmWHREAEwhr03iqXrjoo9acYYNfYxqIhKWybomIbExtfsuVlzyzVeDQL0X8a3589fd/ovEPy1eFtBgSBXCH7QuvRLnLH+uXjgm45DOYe2esRBZQ5hh2EwJIvLlpP8xyksRj+/0EiUEa3bB1jE16MrFP7rEWbKso7n1uG3XeKrxFUY921mfNBLdPPMeixfHT1ntuzQVS8BNT5CGLQ2zII6SoL0mXi6qS4AGxM7qSw+e/Ok0C8OX7M7dZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lMKPgbZ82ovOX4ICOp+iMdZQe9vog8EzhccbYRDxyo0=;
 b=TeGqclsnTFkBQb1erNalJ6wper4Hz+OOzNeNfKGvUVXdhSKE5dc9OCSxuCm1UckxzCAt0KNKXzMkl6UqbToNoADGtz60KP6c8T9kH/kYI9UGbr/xXZ6on2+EA4+nZTb52aCr2Hzx+pSCcpwG/FsuD35eTdnI+FPhRFh7ov77Ido=
Received: from MN2PR19CA0023.namprd19.prod.outlook.com (2603:10b6:208:178::36)
 by DM5PR0201MB3477.namprd02.prod.outlook.com (2603:10b6:4:79::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Fri, 26 Feb
 2021 21:57:23 +0000
Received: from BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:178:cafe::81) by MN2PR19CA0023.outlook.office365.com
 (2603:10b6:208:178::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Fri, 26 Feb 2021 21:57:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT007.mail.protection.outlook.com (10.152.77.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 21:57:23 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 26 Feb 2021 13:57:23 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 26 Feb 2021 13:57:23 -0800
Envelope-to: max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 lizhi.hou@xilinx.com,
 stefanos@xilinx.com,
 robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.3.3] (port=52158)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <max.zhen@xilinx.com>)
        id 1lFl6w-0005yc-Ur; Fri, 26 Feb 2021 13:57:22 -0800
Subject: Re: [PATCH V3 XRT Alveo 05/18] fpga: xrt: group platform driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-6-lizhih@xilinx.com>
 <ebf64992-4067-18c2-661d-6c3a3b64c7c0@redhat.com>
From:   Max Zhen <max.zhen@xilinx.com>
Message-ID: <4eb879cf-c2c3-5f85-79a4-73d02a9fa523@xilinx.com>
Date:   Fri, 26 Feb 2021 13:57:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <ebf64992-4067-18c2-661d-6c3a3b64c7c0@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6eb337a-ee6e-4423-fdb0-08d8daa17f61
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3477:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB3477524AAA9211571DAAD732B99D9@DM5PR0201MB3477.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a/TEhnrIaYCM/2IBP+yQhori3Cp1Xo385gHPTooEvB77iIQhVHyCFYwbyXd3mosVIR7RMSLbyXIeeQho5MiSdNRUNjpFSMeAyOoQjYb6K38vXuiAxGQSRCmayN1340Ea7QF7E/9IVgLfSB2RS1BwBngbIJ9/sgzldsbkwbrdz7NaHLwzh+L2cUWj+l7p+GcyF9SF4AEWM+cYGzhU/Hqzj1cXTLeGbEuA+cIyzuuvfcBFsv/ZCEd3eMdp0xydOTGUEW629xMy2VjUrdWjwUfKknQv79TG0XNcNA9Xsj1giSqp0F8uSxsDlVGCn4Ny5IqG6gMHTmc+zcbb+kcft2SMO+/GgltBNFvLIoMxNOve85PktjqGoUxg6aBePVTN4HFidb+Cf4U5mR6SWEvEg+z/8/mY8xwKWLLpboy3ay/Pkfslc+Cep6m7HMIfMB6sjsTkfkPmdo6eH/SwA3nZgDmyGa21YfHBNYkxcM3X1PetTms/TteenwPxHlWgPhVqDQJYPM9CDC79cEwXDTqMHrTTqKrG8HOJZ2auO9MLH7WCJIsduz5NIwuTERQx7OEx7eZ1OchUqLlXF6mnkCA+BlOPnBKVZxVm5Wzv16DnHnymfdrPOAIM4pfiP7CgHfznmrq+CNLeo9pnCqjcXUq0pG++CDq2hEzRteGN+3p7QzsxoLus7MqVwtQyJN6pNIBRAsFSxW3lP+uV/2i6SOhSIIJr0VStUvXr5Xz9Q51KhCbgqLE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(46966006)(36840700001)(82740400003)(82310400003)(44832011)(70206006)(53546011)(31696002)(4326008)(30864003)(31686004)(107886003)(36860700001)(5660300002)(70586007)(186003)(7636003)(9786002)(47076005)(478600001)(336012)(426003)(2616005)(356005)(2906002)(83380400001)(36756003)(110136005)(8936002)(26005)(316002)(36906005)(54906003)(8676002)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 21:57:23.3234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6eb337a-ee6e-4423-fdb0-08d8daa17f61
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT007.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3477
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 2/22/21 10:50 AM, Tom Rix wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> group driver that manages life cycle of a bunch of leaf driver instances
>> and bridges them with root.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/group.h |  27 ++++
>>   drivers/fpga/xrt/lib/group.c     | 265 +++++++++++++++++++++++++++++++
>>   2 files changed, 292 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/group.h
>>   create mode 100644 drivers/fpga/xrt/lib/group.c
>>
>> diff --git a/drivers/fpga/xrt/include/group.h b/drivers/fpga/xrt/include/group.h
>> new file mode 100644
>> index 000000000000..1874cdd5120d
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/group.h
>> @@ -0,0 +1,27 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for Xilinx Runtime (XRT) driver
> A bit too generic, please add a description or remove.


Will remove.


>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_GROUP_H_
>> +#define _XRT_GROUP_H_
>> +
>> +#include "xleaf.h"
> This is patch 6, consider comments on patch 4.


Will move this header to other patch.


>> +
>> +/*
>> + * Group driver IOCTL calls.
> Are these really ioctl calls?
>
> Seems more like messages between nodes in a tree.
>
> Consider changing to better jagon, maybe ioctl -> msg


You're right. They are not really ioctl calls. They are just calls b/w 
leaf nodes. I changed to leaf calls/commands.


>
>> + */
>> +enum xrt_group_ioctl_cmd {
>> +     XRT_GROUP_GET_LEAF = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> XRT_LEAF_CUSTOM_BASE is a #define, while these are enums. To be consistent, the XRT_LEAF_CUSTOM_BASE should be an enum in xleaf, you can initialize it to 64 there.


Will fix.


>> +     XRT_GROUP_PUT_LEAF,
>> +     XRT_GROUP_INIT_CHILDREN,
>> +     XRT_GROUP_FINI_CHILDREN,
>> +     XRT_GROUP_TRIGGER_EVENT,
>> +};
>> +
>> +#endif       /* _XRT_GROUP_H_ */
>> diff --git a/drivers/fpga/xrt/lib/group.c b/drivers/fpga/xrt/lib/group.c
>> new file mode 100644
>> index 000000000000..6ba56eea479b
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/group.c
>> @@ -0,0 +1,265 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo FPGA Group Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include "xleaf.h"
>> +#include "subdev_pool.h"
>> +#include "group.h"
>> +#include "metadata.h"
>> +#include "main.h"
>> +
>> +#define XRT_GRP "xrt_group"
>> +
>> +struct xrt_group {
>> +     struct platform_device *pdev;
>> +     struct xrt_subdev_pool leaves;
>> +     bool leaves_created;
>> +     struct mutex lock; /* lock for group */
>> +};
>> +
>> +static int xrt_grp_root_cb(struct device *dev, void *parg,
>> +                        u32 cmd, void *arg)
> could 'cmd' be some enum type ?


Will fix.


>> +{
>> +     int rc;
>> +     struct platform_device *pdev =
>> +             container_of(dev, struct platform_device, dev);
>> +     struct xrt_group *xg = (struct xrt_group *)parg;
>> +
>> +     switch (cmd) {
>> +     case XRT_ROOT_GET_LEAF_HOLDERS: {
>> +             struct xrt_root_ioctl_get_holders *holders =
>> +                     (struct xrt_root_ioctl_get_holders *)arg;
>> +             rc = xrt_subdev_pool_get_holders(&xg->leaves,
>> +                                              holders->xpigh_pdev,
>> +                                              holders->xpigh_holder_buf,
>> +                                              holders->xpigh_holder_buf_len);
>> +             break;
>> +     }
>> +     default:
>> +             /* Forward parent call to root. */
>> +             rc = xrt_subdev_root_request(pdev, cmd, arg);
>> +             break;
>> +     }
>> +
>> +     return rc;
>> +}
>> +
>> +static int xrt_grp_create_leaves(struct xrt_group *xg)
>> +{
>> +     struct xrt_subdev_platdata *pdata = DEV_PDATA(xg->pdev);
>> +     enum xrt_subdev_id did;
>> +     struct xrt_subdev_endpoints *eps = NULL;
>> +     int ep_count = 0, i, ret = 0, failed = 0;
>> +     unsigned long mlen;
>> +     char *dtb, *grp_dtb = NULL;
>> +     const char *ep_name;
>> +
>> +     mutex_lock(&xg->lock);
>> +
>> +     if (xg->leaves_created) {
>> +             mutex_unlock(&xg->lock);
> This happens should be programming error, so print out some error message


The root driver does not remember which group has created leaves or not. 
It'll just blindly make the call. The group driver itself should 
remember and tell the root that it's done already or not. So, this is 
not considered as an error.


>> +             return -EEXIST;
>> +     }
>> +
>> +     xrt_info(xg->pdev, "bringing up leaves...");
>> +
>> +     /* Create all leaves based on dtb. */
>> +     if (!pdata)
>> +             goto bail;
> move to above the lock and fail with something like -EINVAL


Will fix.


>> +
>> +     mlen = xrt_md_size(DEV(xg->pdev), pdata->xsp_dtb);
>> +     if (mlen == XRT_MD_INVALID_LENGTH) {
>> +             xrt_err(xg->pdev, "invalid dtb, len %ld", mlen);
>> +             goto bail;
>> +     }
>> +
>> +     grp_dtb = vmalloc(mlen);
>> +     if (!grp_dtb)
>> +             goto bail;
> failed is only set in the loop. This is an unreported -ENOMEM


Will fix.


>> +
>> +     memcpy(grp_dtb, pdata->xsp_dtb, mlen);
>> +     for (did = 0; did < XRT_SUBDEV_NUM;) {
> why isn't the did incremented ?


This is not a bug, but I will fix it by rewriting this function so that 
it'll be easier to follow (hopefully :-)).


>> +             eps = eps ? eps + 1 : xrt_drv_get_endpoints(did);
> this assumes the enpoints are in an array and accessed serially.
>
> this is fragile.
>
> convert to using just the xrt_drv_get_endpoints() call


It does not seem to be fragile? The endpoint data structure is private 
data structure so it has to be an array as defined. It's usage is just 
like an ID table as we have in other PCIE drivers.


>
>> +             if (!eps || !eps->xse_names) {
>> +                     did++;
>> +                     eps = NULL;
>> +                     continue;
>> +             }
>> +             ret = xrt_md_create(DEV(xg->pdev), &dtb);
>> +             if (ret) {
>> +                     xrt_err(xg->pdev, "create md failed, drv %s",
>> +                             xrt_drv_name(did));
>> +                     failed++;
> failed but no cleanup of earier successes


The leaves already created will still be there until the group is 
destroyed. This is not considered as fatal error.


>> +                     continue;
>> +             }
>> +             for (i = 0; eps->xse_names[i].ep_name ||
> this assumes that xse_names[] always has a guard.
>
> why not use xse_min_ep ?


xse_min_ep is to tell caller the minimum number of end points needs to 
be collected before instantiate the leaf driver. it does not indicate 
exactly how many end points this leaf can handle (it might be able to 
handle more). So, the guard is necessary to tell caller total number of 
end points it can handle.


>
>> +                  eps->xse_names[i].regmap_name; i++) {
>> +                     ep_name = (char *)eps->xse_names[i].ep_name;
>> +                     if (!ep_name) {
>> +                             xrt_md_get_compatible_endpoint(DEV(xg->pdev),
>> +                                                            grp_dtb,
>> +                                                            eps->xse_names[i].regmap_name,
>> +                                                            &ep_name);
>> +                     }
>> +                     if (!ep_name)
>> +                             continue;
>> +
>> +                     ret = xrt_md_copy_endpoint(DEV(xg->pdev),
>> +                                                dtb, grp_dtb, ep_name,
>> +                                                (char *)eps->xse_names[i].regmap_name,
>> +                                                NULL);
>> +                     if (ret)
>> +                             continue;
>> +                     xrt_md_del_endpoint(DEV(xg->pdev), grp_dtb, ep_name,
>> +                                         (char *)eps->xse_names[i].regmap_name);
>> +                     ep_count++;
>> +             }
>> +             if (ep_count >= eps->xse_min_ep) {
> This only happens if all additions are successful.


This happens if the minimum number of end points has been collected. 
Anyway, the function is going to be rewritten.


>> +                     ret = xrt_subdev_pool_add(&xg->leaves, did,
>> +                                               xrt_grp_root_cb, xg, dtb);
>> +                     eps = NULL;
>> +                     if (ret < 0) {
>> +                             failed++;
>> +                             xrt_err(xg->pdev, "failed to create %s: %d",
>> +                                     xrt_drv_name(did), ret);
>> +                     }
>> +             } else if (ep_count > 0) {
>> +                     xrt_md_copy_all_endpoints(DEV(xg->pdev), grp_dtb, dtb);
>> +             }
>> +             vfree(dtb);
>> +             ep_count = 0;
>> +     }
>> +
>> +     xg->leaves_created = true;
> This is true even if some failed ?


Yes, this is OK. Some functionality may be missing if some leaves can be 
instantiated, but the group will be in leaves created state now.


>> +
>> +bail:
>> +     vfree(grp_dtb);
>> +     mutex_unlock(&xg->lock);
>> +
>> +     return failed == 0 ? 0 : -ECHILD;
>> +}
>> +
>> +static void xrt_grp_remove_leaves(struct xrt_group *xg)
>> +{
>> +     mutex_lock(&xg->lock);
>> +
>> +     if (!xg->leaves_created) {
>> +             mutex_unlock(&xg->lock);
>> +             return;
>> +     }
>> +
>> +     xrt_info(xg->pdev, "tearing down leaves...");
>> +     xrt_subdev_pool_fini(&xg->leaves);
> partial failure above and the subdev_pool is not created ?


It is still created, just not fully populated.


>> +     xg->leaves_created = false;
>> +
>> +     mutex_unlock(&xg->lock);
>> +}
>> +
>> +static int xrt_grp_probe(struct platform_device *pdev)
>> +{
>> +     struct xrt_group *xg;
>> +
>> +     xrt_info(pdev, "probing...");
>> +
>> +     xg = devm_kzalloc(&pdev->dev, sizeof(*xg), GFP_KERNEL);
>> +     if (!xg)
>> +             return -ENOMEM;
>> +
>> +     xg->pdev = pdev;
>> +     mutex_init(&xg->lock);
>> +     xrt_subdev_pool_init(DEV(pdev), &xg->leaves);
>> +     platform_set_drvdata(pdev, xg);
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_grp_remove(struct platform_device *pdev)
>> +{
>> +     struct xrt_group *xg = platform_get_drvdata(pdev);
>> +
>> +     xrt_info(pdev, "leaving...");
>> +     xrt_grp_remove_leaves(xg);
> lock ?


xrt_grp_remove_leaves() takes lock internally.


Thanks,

Max

>
> Tom
>
>> +     return 0;
>> +}
>> +
>> +static int xrt_grp_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
>> +{
>> +     int rc = 0;
>> +     struct xrt_group *xg = platform_get_drvdata(pdev);
>> +
>> +     switch (cmd) {
>> +     case XRT_XLEAF_EVENT:
>> +             /* Simply forward to every child. */
>> +             xrt_subdev_pool_handle_event(&xg->leaves,
>> +                                          (struct xrt_event *)arg);
>> +             break;
>> +     case XRT_GROUP_GET_LEAF: {
>> +             struct xrt_root_ioctl_get_leaf *get_leaf =
>> +                     (struct xrt_root_ioctl_get_leaf *)arg;
>> +
>> +             rc = xrt_subdev_pool_get(&xg->leaves, get_leaf->xpigl_match_cb,
>> +                                      get_leaf->xpigl_match_arg,
>> +                                      DEV(get_leaf->xpigl_pdev),
>> +                                      &get_leaf->xpigl_leaf);
>> +             break;
>> +     }
>> +     case XRT_GROUP_PUT_LEAF: {
>> +             struct xrt_root_ioctl_put_leaf *put_leaf =
>> +                     (struct xrt_root_ioctl_put_leaf *)arg;
>> +
>> +             rc = xrt_subdev_pool_put(&xg->leaves, put_leaf->xpipl_leaf,
>> +                                      DEV(put_leaf->xpipl_pdev));
>> +             break;
>> +     }
>> +     case XRT_GROUP_INIT_CHILDREN:
>> +             rc = xrt_grp_create_leaves(xg);
>> +             break;
>> +     case XRT_GROUP_FINI_CHILDREN:
>> +             xrt_grp_remove_leaves(xg);
>> +             break;
>> +     case XRT_GROUP_TRIGGER_EVENT:
>> +             xrt_subdev_pool_trigger_event(&xg->leaves, (enum xrt_events)(uintptr_t)arg);
>> +             break;
>> +     default:
>> +             xrt_err(pdev, "unknown IOCTL cmd %d", cmd);
>> +             rc = -EINVAL;
>> +             break;
>> +     }
>> +     return rc;
>> +}
>> +
>> +static struct xrt_subdev_drvdata xrt_grp_data = {
>> +     .xsd_dev_ops = {
>> +             .xsd_ioctl = xrt_grp_ioctl,
>> +     },
>> +};
>> +
>> +static const struct platform_device_id xrt_grp_id_table[] = {
>> +     { XRT_GRP, (kernel_ulong_t)&xrt_grp_data },
>> +     { },
>> +};
>> +
>> +static struct platform_driver xrt_group_driver = {
>> +     .driver = {
>> +             .name    = XRT_GRP,
>> +     },
>> +     .probe   = xrt_grp_probe,
>> +     .remove  = xrt_grp_remove,
>> +     .id_table = xrt_grp_id_table,
>> +};
>> +
>> +void group_leaf_init_fini(bool init)
>> +{
>> +     if (init)
>> +             xleaf_register_driver(XRT_SUBDEV_GRP, &xrt_group_driver, NULL);
>> +     else
>> +             xleaf_unregister_driver(XRT_SUBDEV_GRP);
>> +}
