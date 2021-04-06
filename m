Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D16935592E
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244099AbhDFQ34 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 12:29:56 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:37345
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233255AbhDFQ3z (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Apr 2021 12:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Utdseex+Ijup1X39OySGNE4n33BTCM7lRyxO+nDWaQ1h7euht2F78tc7kp7xJOtwx1FrW79Pph8bh3KyRvsQbSJ7TZWdFHSmI/qY8T45VTOKasGsRVh9Fm/pgrZ0+BOtHSGxWQi6SflZmrL2cO4LOGgJw29HIFZ8s4EjddOSEVu0km6P3jPdjXS5AgJkktxvC7ScYpxK49k3de0RqIPJS5b7oWhyobVSEsrKVq1/DnE7Am8SKGdKVnEV3QtLPLwz4ow8QfEbkAsfeWZj8Dt9eg9p+It+/LUSwVWsEMOOxuuVT1NHgGKfzc/YMXIY1PUhu9q+vJmaSnjmABFXR6dFQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mXrylp8RACUgxl9HVMFJD787qo2YWlB1ZlBOzTAz6g=;
 b=VRDtfHXdAqkviZ1jRsweF5sWf4PCmWHS4Z69DC7DYGmvKMKfu7Ms0Tos16ZDUs2aVO7BkUxosIrVzG96sPBQpCOd3dLKeUgO+ZYjXyX6Uyfdjfxsj4rHby5cchERyb0pgcHwaIUnnp4uXRTFTxHCXypPB/IDSa7ORnYuieiVZzh/XUnKADAREJP8htJzgmgYQByLJHQrzOuezkzAsQeR9mtNckzhD3h9qXBcmrA7f2gILQiKgz09ZJxEMgZseAnnLOj/cx71saKhnxaZJk+Vs/tCSDg5lz4vnwckqEM4IWfRMIjWBOeQ3IaN0R5Kbt+8gQY1u3hHj+FKbp2XT7vuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mXrylp8RACUgxl9HVMFJD787qo2YWlB1ZlBOzTAz6g=;
 b=V8D2bg60SIw17YFv8V4nQCMwRwqbNDeGD1w9LbO8SZTicpm0Xyuj11QDXq1uaQBo9COmAkPiKKBn3iz/YnFmWQlvx3e5Fa9TZ6FsKGg3OOHiJpJ4Zt4663uyRBy/NkBaQ6ZsdYqTklpOHjg6sJVOVmVi6U2Yvr1UM3Ji+Je0i5w=
Received: from DM6PR07CA0098.namprd07.prod.outlook.com (2603:10b6:5:337::31)
 by CH2PR02MB6917.namprd02.prod.outlook.com (2603:10b6:610:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Tue, 6 Apr
 2021 16:29:46 +0000
Received: from DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::ac) by DM6PR07CA0098.outlook.office365.com
 (2603:10b6:5:337::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend
 Transport; Tue, 6 Apr 2021 16:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT040.mail.protection.outlook.com (10.13.5.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 16:29:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 09:29:44 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 6 Apr 2021 09:29:44 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.3.3] (port=48114)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <max.zhen@xilinx.com>)
        id 1lToaG-0005aI-M5; Tue, 06 Apr 2021 09:29:44 -0700
Subject: Re: [PATCH V4 XRT Alveo 06/20] fpga: xrt: char dev node helper
 functions
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <sonal.santan@xilinx.com>,
        <yliu@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-7-lizhi.hou@xilinx.com>
 <755d73b9-1e23-c2e9-1502-15df14b9ed35@redhat.com>
From:   Max Zhen <max.zhen@xilinx.com>
Message-ID: <d557363e-6ef8-2f7b-12d9-be16874ae27a@xilinx.com>
Date:   Tue, 6 Apr 2021 09:29:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <755d73b9-1e23-c2e9-1502-15df14b9ed35@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aaada601-e60a-4139-aeb7-08d8f91930af
X-MS-TrafficTypeDiagnostic: CH2PR02MB6917:
X-Microsoft-Antispam-PRVS: <CH2PR02MB69172E1C2C289DE27770D205B9769@CH2PR02MB6917.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CpTAXtlY0GqXh1BO3eyGePBeQrsBfsUpZGWYMFEpQAwG/K0MVUfBbtKLna8iwnACXLbThSUgp9IjYjr/C3roQeOi3BrfRYAXGkKjefnA3yqOgWm3YerUxGqVX7lxvFKZSz6Tp+Awr0q/rwlMOB0lqCdLyrpSjeJrqorWioR97zLXgsaN7Oa1+nWwUZkTGG69uqspGrW79gJkA/VZJvr2imM/8uI9gmkmQiWILjtssNUMWSkM9PBYdSzs7CCIJygXojV0Vju//CHDu35Qh/JvtKEArYXNPMcTtltB70aKfBq9WTPP5VM/31Q/pOfk8aFmmmL3v1Y2XtV63Yv8BRhixeIzTR8eu2JC9u9xlyl7gNgaSkDrLGyATUo2KHIRAFiLMNaC3XOP/8NXtmJyYpFqrn463GWm7dJqMDILur093pngonLMJB3fCoITg5PsB0/7Wcl9fR4o4rH6QHktueZGZJ5V/ZN2deIMp/wuY3jX89iF3vZ8MqSixeUuEOJ+Y0er+CPkBlwMdpBUbfa+2Rc65pllSd5PpVPQElEXtcLrteDUU9Pnoig//VLeRm560KHYDsXP6hBAN6xrBWK/rsXGf3k0u2GS3EMjvyfNHKXbiu3RIongTGmoj57DudijXdgpougXeSJ3zUAPbnwZOOleS31mTnrIAN9oS3b+4P3B+AHWrBehkiJLFXik8QO9X1iJ4xjQHweGxRtp07IK7VadKH1QdfBS6e68f2mYbt9wJjM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(39850400004)(396003)(346002)(36840700001)(46966006)(36756003)(110136005)(316002)(53546011)(4326008)(336012)(186003)(26005)(47076005)(478600001)(44832011)(54906003)(5660300002)(426003)(83380400001)(31686004)(70586007)(9786002)(356005)(7636003)(31696002)(8936002)(8676002)(36906005)(82310400003)(82740400003)(107886003)(2616005)(36860700001)(2906002)(70206006)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 16:29:45.8344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaada601-e60a-4139-aeb7-08d8f91930af
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6917
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/30/21 6:45 AM, Tom Rix wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> It is unclear from the changelog if this new patch was split from an existing patch or new content.
>
> the file ops seem to come from mgmnt/main.c, which call what could be file ops here.  why is this complicated redirection needed ?


This is part of infra code which is split from subdev.c, not from 
mgmt/main.c. Sorry about the confusion. We further split infra code to 
avoid having one huge patch for review.


>
> On 3/23/21 10:29 PM, Lizhi Hou wrote:
>> Helper functions for char device node creation / removal for platform
>> drivers. This is part of platform driver infrastructure.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/fpga/xrt/lib/cdev.c | 232 ++++++++++++++++++++++++++++++++++++
>>   1 file changed, 232 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/lib/cdev.c
>>
>> diff --git a/drivers/fpga/xrt/lib/cdev.c b/drivers/fpga/xrt/lib/cdev.c
>> new file mode 100644
>> index 000000000000..38efd24b6e10
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/cdev.c
>> @@ -0,0 +1,232 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo FPGA device node helper functions.
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#include "xleaf.h"
>> +
>> +extern struct class *xrt_class;
>> +
>> +#define XRT_CDEV_DIR         "xfpga"
> maybe "xrt_fpga" or just "xrt"


Will change it to just "xrt", yes.


>> +#define INODE2PDATA(inode)   \
>> +     container_of((inode)->i_cdev, struct xrt_subdev_platdata, xsp_cdev)
>> +#define INODE2PDEV(inode)    \
>> +     to_platform_device(kobj_to_dev((inode)->i_cdev->kobj.parent))
>> +#define CDEV_NAME(sysdev)    (strchr((sysdev)->kobj.name, '!') + 1)
>> +
>> +/* Allow it to be accessed from cdev. */
>> +static void xleaf_devnode_allowed(struct platform_device *pdev)
>> +{
>> +     struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
>> +
>> +     /* Allow new opens. */
>> +     mutex_lock(&pdata->xsp_devnode_lock);
>> +     pdata->xsp_devnode_online = true;
>> +     mutex_unlock(&pdata->xsp_devnode_lock);
>> +}
>> +
>> +/* Turn off access from cdev and wait for all existing user to go away. */
>> +static int xleaf_devnode_disallowed(struct platform_device *pdev)
>> +{
>> +     int ret = 0;
>> +     struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
>> +
>> +     mutex_lock(&pdata->xsp_devnode_lock);
>> +
>> +     /* Prevent new opens. */
>> +     pdata->xsp_devnode_online = false;
>> +     /* Wait for existing user to close. */
>> +     while (!ret && pdata->xsp_devnode_ref) {
>> +             int rc;
>> +
>> +             mutex_unlock(&pdata->xsp_devnode_lock);
>> +             rc = wait_for_completion_killable(&pdata->xsp_devnode_comp);
>> +             mutex_lock(&pdata->xsp_devnode_lock);
>> +
>> +             if (rc == -ERESTARTSYS) {
>> +                     /* Restore online state. */
>> +                     pdata->xsp_devnode_online = true;
>> +                     xrt_err(pdev, "%s is in use, ref=%d",
>> +                             CDEV_NAME(pdata->xsp_sysdev),
>> +                             pdata->xsp_devnode_ref);
>> +                     ret = -EBUSY;
>> +             }
>> +     }
>> +
>> +     mutex_unlock(&pdata->xsp_devnode_lock);
>> +
>> +     return ret;
>> +}
>> +
>> +static struct platform_device *
>> +__xleaf_devnode_open(struct inode *inode, bool excl)
>> +{
>> +     struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
>> +     struct platform_device *pdev = INODE2PDEV(inode);
>> +     bool opened = false;
>> +
>> +     mutex_lock(&pdata->xsp_devnode_lock);
>> +
>> +     if (pdata->xsp_devnode_online) {
>> +             if (excl && pdata->xsp_devnode_ref) {
>> +                     xrt_err(pdev, "%s has already been opened exclusively",
>> +                             CDEV_NAME(pdata->xsp_sysdev));
>> +             } else if (!excl && pdata->xsp_devnode_excl) {
>> +                     xrt_err(pdev, "%s has been opened exclusively",
>> +                             CDEV_NAME(pdata->xsp_sysdev));
>> +             } else {
>> +                     pdata->xsp_devnode_ref++;
>> +                     pdata->xsp_devnode_excl = excl;
>> +                     opened = true;
>> +                     xrt_info(pdev, "opened %s, ref=%d",
>> +                              CDEV_NAME(pdata->xsp_sysdev),
>> +                              pdata->xsp_devnode_ref);
>> +             }
>> +     } else {
>> +             xrt_err(pdev, "%s is offline", CDEV_NAME(pdata->xsp_sysdev));
>> +     }
>> +
>> +     mutex_unlock(&pdata->xsp_devnode_lock);
>> +
>> +     pdev = opened ? pdev : NULL;
>> +     return pdev;
>> +}
>> +
>> +struct platform_device *
>> +xleaf_devnode_open_excl(struct inode *inode)
>> +{
>> +     return __xleaf_devnode_open(inode, true);
>> +}
> This function is unused, remove.


This is part of infra's API for leaf driver to call. The caller has been 
removed from this initial patch set to reduce the size of the patch. You 
will see it in the next follow up patch once we finish reviewing current 
one.


>> +
>> +struct platform_device *
>> +xleaf_devnode_open(struct inode *inode)
>> +{
>> +     return __xleaf_devnode_open(inode, false);
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_devnode_open);
> does this really need to be exported ?


Yes, this is part of infra's API in xrt-lib.ko. One of the caller is in 
xrt-mgmt.ko.


>> +
>> +void xleaf_devnode_close(struct inode *inode)
>> +{
>> +     struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
>> +     struct platform_device *pdev = INODE2PDEV(inode);
>> +     bool notify = false;
>> +
>> +     mutex_lock(&pdata->xsp_devnode_lock);
>> +
>> +     WARN_ON(pdata->xsp_devnode_ref == 0);
>> +     pdata->xsp_devnode_ref--;
>> +     if (pdata->xsp_devnode_ref == 0) {
>> +             pdata->xsp_devnode_excl = false;
>> +             notify = true;
>> +     }
>> +     if (notify) {
>> +             xrt_info(pdev, "closed %s, ref=%d",
>> +                      CDEV_NAME(pdata->xsp_sysdev), pdata->xsp_devnode_ref);
> xsp_devnode_ref will always be 0, so no need to report it.


Will remove.


>> +     } else {
>> +             xrt_info(pdev, "closed %s, notifying waiter",
>> +                      CDEV_NAME(pdata->xsp_sysdev));
>> +     }
>> +
>> +     mutex_unlock(&pdata->xsp_devnode_lock);
>> +
>> +     if (notify)
>> +             complete(&pdata->xsp_devnode_comp);
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_devnode_close);
>> +
>> +static inline enum xrt_subdev_file_mode
>> +devnode_mode(struct xrt_subdev_drvdata *drvdata)
>> +{
>> +     return drvdata->xsd_file_ops.xsf_mode;
>> +}
>> +
>> +int xleaf_devnode_create(struct platform_device *pdev, const char *file_name,
>> +                      const char *inst_name)
>> +{
>> +     struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(pdev);
>> +     struct xrt_subdev_file_ops *fops = &drvdata->xsd_file_ops;
>> +     struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
>> +     struct cdev *cdevp;
>> +     struct device *sysdev;
>> +     int ret = 0;
>> +     char fname[256];
>> +
>> +     mutex_init(&pdata->xsp_devnode_lock);
>> +     init_completion(&pdata->xsp_devnode_comp);
>> +
>> +     cdevp = &DEV_PDATA(pdev)->xsp_cdev;
>> +     cdev_init(cdevp, &fops->xsf_ops);
>> +     cdevp->owner = fops->xsf_ops.owner;
>> +     cdevp->dev = MKDEV(MAJOR(fops->xsf_dev_t), pdev->id);
>> +
>> +     /*
>> +      * Set pdev as parent of cdev so that when pdev (and its platform
>> +      * data) will not be freed when cdev is not freed.
>> +      */
>> +     cdev_set_parent(cdevp, &DEV(pdev)->kobj);
>> +
>> +     ret = cdev_add(cdevp, cdevp->dev, 1);
>> +     if (ret) {
>> +             xrt_err(pdev, "failed to add cdev: %d", ret);
>> +             goto failed;
>> +     }
>> +     if (!file_name)
>> +             file_name = pdev->name;
>> +     if (!inst_name) {
>> +             if (devnode_mode(drvdata) == XRT_SUBDEV_FILE_MULTI_INST) {
>> +                     snprintf(fname, sizeof(fname), "%s/%s/%s.%u",
>> +                              XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
>> +                              file_name, pdev->id);
>> +             } else {
>> +                     snprintf(fname, sizeof(fname), "%s/%s/%s",
>> +                              XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
>> +                              file_name);
>> +             }
>> +     } else {
>> +             snprintf(fname, sizeof(fname), "%s/%s/%s.%s", XRT_CDEV_DIR,
>> +                      DEV_PDATA(pdev)->xsp_root_name, file_name, inst_name);
>> +     }
>> +     sysdev = device_create(xrt_class, NULL, cdevp->dev, NULL, "%s", fname);
>> +     if (IS_ERR(sysdev)) {
>> +             ret = PTR_ERR(sysdev);
>> +             xrt_err(pdev, "failed to create device node: %d", ret);
>> +             goto failed_cdev_add;
>> +     }
>> +     pdata->xsp_sysdev = sysdev;
>> +
>> +     xleaf_devnode_allowed(pdev);
>> +
>> +     xrt_info(pdev, "created (%d, %d): /dev/%s",
>> +              MAJOR(cdevp->dev), pdev->id, fname);
>> +     return 0;
>> +
>> +failed_cdev_add:
>> +     cdev_del(cdevp);
>> +failed:
>> +     cdevp->owner = NULL;
>> +     return ret;
>> +}
>> +
>> +int xleaf_devnode_destroy(struct platform_device *pdev)
>> +{
>> +     struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
>> +     struct cdev *cdevp = &pdata->xsp_cdev;
>> +     dev_t dev = cdevp->dev;
>> +     int rc;
>> +
>> +     rc = xleaf_devnode_disallowed(pdev);
>> +     if (rc)
>> +             return rc;
> Failure of one leaf to be destroyed is not handled well.
>
> could a able to destroy check be done over the whole group ?


Yes, this is not handled properly. Handling this type of error during 
cleaning up code path is not very clean. I think it might make more 
sense to just change the code so that xleaf_devnode_disallowed() will 
not fail. It will instead just waiting for existing user to quit. This 
is just like the remove callback of a platform device. It does not 
return error.

Or maybe there is a better way to handle the error like this?

Thanks,

Max

>
> Tom
>
>> +
>> +     xrt_info(pdev, "removed (%d, %d): /dev/%s/%s", MAJOR(dev), MINOR(dev),
>> +              XRT_CDEV_DIR, CDEV_NAME(pdata->xsp_sysdev));
>> +     device_destroy(xrt_class, cdevp->dev);
>> +     pdata->xsp_sysdev = NULL;
>> +     cdev_del(cdevp);
>> +     return 0;
>> +}
