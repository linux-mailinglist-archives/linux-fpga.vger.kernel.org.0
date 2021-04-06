Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55770355E15
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 23:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbhDFVm7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 17:42:59 -0400
Received: from mail-mw2nam12on2064.outbound.protection.outlook.com ([40.107.244.64]:47585
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234334AbhDFVm7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Apr 2021 17:42:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTXUw+c1EM0PP57W+3cOcq+BhxZzsoWPSBdKi7aUwjb5tIzgu7z+zhHYJq+TkMUYbLEAUAWwTTw1MPMdNHxVmb7B+3hmuv+V8lfRo0rFBCr4VmojbedSWfXeq9lNHjpVvevjboBk59lKpVd0GGz1+c5dGaSjdItEcQi1KvHTlSIc2nuNdgbUs7QYHgWPUNTz6FjAlmOl1TQUn7J9by+af71NvppBtf0QLgQUPyPGea5YqqR5Umam3SQY9K/M0bNfD8bCyDVig+0cWmyVdymlaC841qdm5jHr7XkhQxYigbuNE+XWbWI80/h4H3eS2BjCwPcl7QuXrT8gnDhch3mADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZKsy+/YgGYuvZET4VUJ1+KnFvomoN8yYDOEg2ulp4M=;
 b=cctK6H5YLy/jA0JJQvF4/UD0PVRzLv0E6L0ZX9x3CEJmvmBBBqIUk+nk5smT977YNdG/av496LDmJisqQ8CjgmCVrQMH8zdDQ3tCY5zHuBV2CBZov3+Mg+V7fLn7ifDV9VEbqT7/GlfI9Kn8/y2O1E737pQupHtz50XrPbTvAg1a5r2LBMFfXdcPlakvQ4Za5DOnHidQVwGk/ck3gca2uvZ51z053fXILTqablMHdImF6hOMpB9ue1PcXYy+/fo9PX1NYwE7ynCHiJvsedwxANXDBv3L7GyX3rJ5zDLFcy5IBxPjCnrgvJl+4zHuq1sQ+zqZ2B5sNBAKIpO1FdRLjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZKsy+/YgGYuvZET4VUJ1+KnFvomoN8yYDOEg2ulp4M=;
 b=FtRDuI07+rFylkTrAa3FzQPATRqhjf5VbBz0+Gp754jV47wOl8JmCB9UKzjJDYIY4coHi4TdIuhwKA3elgpkPeWa1HSvex8Xjd3xrKVReaYgDBT6eTeTRD43n9Rt5QbZNOU6e6+FzLv3wcmPfwKvJwFKD2SweLxrGq3gTk8NAEQ=
Received: from BL1PR13CA0251.namprd13.prod.outlook.com (2603:10b6:208:2ba::16)
 by CY4PR02MB2789.namprd02.prod.outlook.com (2603:10b6:903:11b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 21:42:43 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2ba:cafe::fe) by BL1PR13CA0251.outlook.office365.com
 (2603:10b6:208:2ba::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.8 via Frontend
 Transport; Tue, 6 Apr 2021 21:42:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 21:42:43 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 14:42:42 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 6 Apr 2021 14:42:42 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.3.3] (port=49290)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <max.zhen@xilinx.com>)
        id 1lTtT8-0007kj-Lp; Tue, 06 Apr 2021 14:42:42 -0700
Subject: Re: [PATCH V4 XRT Alveo 05/20] fpga: xrt: group platform driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>, Max Zhen <max.zhen@xilinx.com>
CC:     <linux-fpga@vger.kernel.org>, <sonal.santan@xilinx.com>,
        <yliu@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-6-lizhi.hou@xilinx.com>
 <692776f1-ed9f-5013-a0bf-d6c97d355369@redhat.com>
From:   Max Zhen <max.zhen@xilinx.com>
Message-ID: <d69f6b53-31dc-a749-a1f5-b198561db860@xilinx.com>
Date:   Tue, 6 Apr 2021 14:42:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <692776f1-ed9f-5013-a0bf-d6c97d355369@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f45b3b2-f5f8-46de-8459-08d8f944e905
X-MS-TrafficTypeDiagnostic: CY4PR02MB2789:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2789B6A1DFE641DC8F635DD9B9769@CY4PR02MB2789.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:46;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LYW0912HQSRMsGAf/FmSCYBeiBU4LZbQS2RgsAN32LOV0SdFzWyHbtAf6wxD0HNOI52h8p716a1Ux9aOWEOBKvGZK6woys5yqVSmj4Br6dUYfjpNbgQlSR0SgEoIUzKhjOF4+2LMU6DMke+8hrSTR9usP1k6/tRFcDyCiAYwVQEaFLvJGEpRVuu0sjrklnTqq4phpdW+c23vlLXzIcvd0ebA8e3TvkLDF3UnLyaK8nQ9RTuxMiqmrIuplLKs5nXaWeaJPjbKbrVl8qToaB6B1t23S7bEgruzZr0IrScr7Gs75tJ1qsTINOKDUoYzePeTCA5+hn3iRQGuGsMwNU9wBVT7Vfk1zFfc+QEemrCjYgnIrKhLAudrY3FE+WpwcaIgErss+kAb2V8PBDqU+yd8m3kHmKFKwyTxs7aj1Nrj96lcpyftVOIjSlb/5IDJN2+ZkCA2JAAgPjH6OfQXh7UIS2Wjj4mqf+e1Lx7Owy107huCos12IvY7gimYyU8tSApdf5O4gHj5nOLif2vkOzOqfIZ9oc+LhjiIHKZ9VsTRStdTIpiRo6XRW1uBJt4QyAdHrJeSyszXlZeioYEt/RW2h523Wfh01cau9YJYeFCVRPut6qq2oTu9JjrRagMs1y3hZzjpJL1BACIvlLi/6TmWf1lgCTBVKdlK4Efko4O4ryFxfWpIFF8f4fx9MNayglot9DLolq3G3xD2tsdyei5Ql+RSV7euN5AAWJdWCfbDlSc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(8936002)(498600001)(2616005)(82310400003)(5660300002)(356005)(4326008)(8676002)(7636003)(31686004)(44832011)(2906002)(70586007)(70206006)(36860700001)(31696002)(26005)(110136005)(9786002)(36906005)(53546011)(426003)(47076005)(336012)(186003)(36756003)(54906003)(83380400001)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 21:42:43.4061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f45b3b2-f5f8-46de-8459-08d8f944e905
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2789
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 3/30/21 5:52 AM, Tom Rix wrote:
> On 3/23/21 10:29 PM, Lizhi Hou wrote:
>> group driver that manages life cycle of a bunch of leaf driver instances
>> and bridges them with root.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/group.h |  25 +++
>>   drivers/fpga/xrt/lib/group.c     | 286 +++++++++++++++++++++++++++++++
>>   2 files changed, 311 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/group.h
>>   create mode 100644 drivers/fpga/xrt/lib/group.c
>>
>> diff --git a/drivers/fpga/xrt/include/group.h b/drivers/fpga/xrt/include/group.h
>> new file mode 100644
>> index 000000000000..09e9d03f53fe
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/group.h
>> @@ -0,0 +1,25 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
> ok, removed generic boilerplate
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_GROUP_H_
>> +#define _XRT_GROUP_H_
>> +
>> +#include "xleaf.h"
> move header to another patch


Yes, the header is moved to 04/20 patch.


>> +
>> +/*
>> + * Group driver leaf calls.
> ok
>> + */
>> +enum xrt_group_leaf_cmd {
>> +     XRT_GROUP_GET_LEAF = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> ok
>> +     XRT_GROUP_PUT_LEAF,
>> +     XRT_GROUP_INIT_CHILDREN,
>> +     XRT_GROUP_FINI_CHILDREN,
>> +     XRT_GROUP_TRIGGER_EVENT,
>> +};
>> +
>> +#endif       /* _XRT_GROUP_H_ */
>> diff --git a/drivers/fpga/xrt/lib/group.c b/drivers/fpga/xrt/lib/group.c
>> new file mode 100644
>> index 000000000000..7b8716569641
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/group.c
>> @@ -0,0 +1,286 @@
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
>> +#include "lib-drv.h"
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
>> +                        enum xrt_root_cmd cmd, void *arg)
> ok
>> +{
>> +     int rc;
>> +     struct platform_device *pdev =
>> +             container_of(dev, struct platform_device, dev);
>> +     struct xrt_group *xg = (struct xrt_group *)parg;
>> +
>> +     switch (cmd) {
>> +     case XRT_ROOT_GET_LEAF_HOLDERS: {
>> +             struct xrt_root_get_holders *holders =
>> +                     (struct xrt_root_get_holders *)arg;
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
>> +/*
>> + * Cut subdev's dtb from group's dtb based on passed-in endpoint descriptor.
>> + * Return the subdev's dtb through dtbp, if found.
>> + */
>> +static int xrt_grp_cut_subdev_dtb(struct xrt_group *xg, struct xrt_subdev_endpoints *eps,
>> +                               char *grp_dtb, char **dtbp)
>> +{
>> +     int ret, i, ep_count = 0;
>> +     char *dtb = NULL;
>> +
>> +     ret = xrt_md_create(DEV(xg->pdev), &dtb);
>> +     if (ret)
>> +             return ret;
>> +
>> +     for (i = 0; eps->xse_names[i].ep_name || eps->xse_names[i].regmap_name; i++) {
>> +             const char *ep_name = eps->xse_names[i].ep_name;
>> +             const char *reg_name = eps->xse_names[i].regmap_name;
>> +
>> +             if (!ep_name)
>> +                     xrt_md_get_compatible_endpoint(DEV(xg->pdev), grp_dtb, reg_name, &ep_name);
>> +             if (!ep_name)
>> +                     continue;
>> +
>> +             ret = xrt_md_copy_endpoint(DEV(xg->pdev), dtb, grp_dtb, ep_name, reg_name, NULL);
>> +             if (ret)
>> +                     continue;
>> +             xrt_md_del_endpoint(DEV(xg->pdev), grp_dtb, ep_name, reg_name);
>> +             ep_count++;
>> +     }
>> +     /* Found enough endpoints, return the subdev's dtb. */
>> +     if (ep_count >= eps->xse_min_ep) {
>> +             *dtbp = dtb;
>> +             return 0;
>> +     }
>> +
>> +     /* Cleanup - Restore all endpoints that has been deleted, if any. */
>> +     if (ep_count > 0) {
>> +             xrt_md_copy_endpoint(DEV(xg->pdev), grp_dtb, dtb,
>> +                                  XRT_MD_NODE_ENDPOINTS, NULL, NULL);
>> +     }
>> +     vfree(dtb);
>> +     *dtbp = NULL;
>> +     return 0;
>> +}
>> +
>> +static int xrt_grp_create_leaves(struct xrt_group *xg)
>> +{
>> +     struct xrt_subdev_platdata *pdata = DEV_PDATA(xg->pdev);
>> +     struct xrt_subdev_endpoints *eps = NULL;
>> +     int ret = 0, failed = 0;
>> +     enum xrt_subdev_id did;
>> +     char *grp_dtb = NULL;
>> +     unsigned long mlen;
>> +
>> +     if (!pdata)
>> +             return -EINVAL;
> ok
>> +
>> +     mlen = xrt_md_size(DEV(xg->pdev), pdata->xsp_dtb);
>> +     if (mlen == XRT_MD_INVALID_LENGTH) {
>> +             xrt_err(xg->pdev, "invalid dtb, len %ld", mlen);
>> +             return -EINVAL;
>> +     }
>> +
>> +     mutex_lock(&xg->lock);
>> +
>> +     if (xg->leaves_created) {
>> +             mutex_unlock(&xg->lock);
> add a comment that this is not an error and/or error is handled elsewhere


Will do.


>> +             return -EEXIST;
>> +     }
>> +
>> +     grp_dtb = vmalloc(mlen);
>> +     if (!grp_dtb) {
>> +             mutex_unlock(&xg->lock);
>> +             return -ENOMEM;
> ok
>> +     }
>> +
>> +     /* Create all leaves based on dtb. */
>> +     xrt_info(xg->pdev, "bringing up leaves...");
>> +     memcpy(grp_dtb, pdata->xsp_dtb, mlen);
>> +     for (did = 0; did < XRT_SUBDEV_NUM; did++) {
> ok
>> +             eps = xrt_drv_get_endpoints(did);
>> +             while (eps && eps->xse_names) {
>> +                     char *dtb = NULL;
>> +
>> +                     ret = xrt_grp_cut_subdev_dtb(xg, eps, grp_dtb, &dtb);
>> +                     if (ret) {
>> +                             failed++;
>> +                             xrt_err(xg->pdev, "failed to cut subdev dtb for drv %s: %d",
>> +                                     xrt_drv_name(did), ret);
>> +                     }
>> +                     if (!dtb) {
>> +                             /*
>> +                              * No more dtb to cut or bad things happened for this instance,
>> +                              * switch to the next one.
>> +                              */
>> +                             eps++;
>> +                             continue;
>> +                     }
>> +
>> +                     /* Found a dtb for this instance, let's add it. */
>> +                     ret = xrt_subdev_pool_add(&xg->leaves, did, xrt_grp_root_cb, xg, dtb);
>> +                     if (ret < 0) {
>> +                             failed++;
>> +                             xrt_err(xg->pdev, "failed to add %s: %d", xrt_drv_name(did), ret);
> add a comment that this is not a fatal error and cleanup happens elsewhere


Will do.


Thanks,

Max


>
> Tom
>
>> +                     }
>> +                     vfree(dtb);
>> +                     /* Continue searching for the same instance from grp_dtb. */
>> +             }
>> +     }
>> +
>> +     xg->leaves_created = true;
>> +     vfree(grp_dtb);
>> +     mutex_unlock(&xg->lock);
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
>> +     return 0;
>> +}
>> +
>> +static int xrt_grp_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
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
>> +             struct xrt_root_get_leaf *get_leaf =
>> +                     (struct xrt_root_get_leaf *)arg;
>> +
>> +             rc = xrt_subdev_pool_get(&xg->leaves, get_leaf->xpigl_match_cb,
>> +                                      get_leaf->xpigl_match_arg,
>> +                                      DEV(get_leaf->xpigl_caller_pdev),
>> +                                      &get_leaf->xpigl_tgt_pdev);
>> +             break;
>> +     }
>> +     case XRT_GROUP_PUT_LEAF: {
>> +             struct xrt_root_put_leaf *put_leaf =
>> +                     (struct xrt_root_put_leaf *)arg;
>> +
>> +             rc = xrt_subdev_pool_put(&xg->leaves, put_leaf->xpipl_tgt_pdev,
>> +                                      DEV(put_leaf->xpipl_caller_pdev));
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
>> +             .xsd_leaf_call = xrt_grp_leaf_call,
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
