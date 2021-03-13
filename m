Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC95339A81
	for <lists+linux-fpga@lfdr.de>; Sat, 13 Mar 2021 01:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhCMApv (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 12 Mar 2021 19:45:51 -0500
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:25345
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231636AbhCMAph (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 12 Mar 2021 19:45:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxapmJV/H0CCFfLzhhoiZgeIk+a1Ayi7NNbE7woaWhQ99OYHIjE7oRdRe7E1cZy1KYRFndHD/5SQ09m6h+znbVYQYgzDghnLJWJEj6ULosbBSHYX76ZCn8MinXRwLvaDMTuOVJlHlx9o5wHIaXX/46xmvjy+mW6hgaK8icIgVTw8QuTmdpxAF0RyuVg9HOubrqRi74jvdsils/kyyS6vlCTuNlbIi04wiQ1GY5VG8uh1BIRrlCmomBJabsa/i5Pn1IJL+zLAfQ12qTYG2v6Tt4TQvyg97jfepddOKBBjfbEUhP1R2uns9DbPzjNR9rhpd/iqErFsdZYbVBaF+l9OBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GlOOajXUEsbfn2jlAS3NTZQ9sRgVGRP+VW6uK3CDJ8=;
 b=IaGyeqpm3zXvniCN+zkfZaxVx0YC5MwdPkXzrcsM7dRv1aW5ZUfsz1wAMT2d2b6437Pi1XbHqxM8IYv3Up1qy6md3+jVLzpOE4Q0vJqWVmsuMvU+3mXu2mVh2kGS1M2SGYanORgbbexDEZ15u4HasINKcfNoFKxlw/oZCv86WdKmrP7LBopqXzXMJBiy2ExYRSM8sKluswva/winbGx0L384DdQsOMOJCTj+P6OJGODkNlTFo2pDlva5sHQL89Y7/W16As03RScUy7wResZi+7QUDisre54FzlqnNuRI8k/4iqDMzqyyuRTub8LjaJK+vQSsPlqkQ+5Z7UP6luV1oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7GlOOajXUEsbfn2jlAS3NTZQ9sRgVGRP+VW6uK3CDJ8=;
 b=GLRsXiCom2Jc0SwHi4GPWXsHMppGkORDvhyS8mOaE2aaKHt8FRzGPX4IYxiFiFjPTG/cnpfKD++2NkMurvTp2+gSsST7MNp1hzNDUvHtPKPW3N5NnCS7dGv3j5AgiAO4+zRAURGDdYSleN3VD7pwcrkruBAg+O1tbis0S+hdR6A=
Received: from CY4PR06CA0049.namprd06.prod.outlook.com (2603:10b6:903:13d::11)
 by SN4PR0201MB3502.namprd02.prod.outlook.com (2603:10b6:803:4c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Sat, 13 Mar
 2021 00:45:35 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:13d:cafe::6c) by CY4PR06CA0049.outlook.office365.com
 (2603:10b6:903:13d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Sat, 13 Mar 2021 00:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.25 via Frontend Transport; Sat, 13 Mar 2021 00:45:35 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 12 Mar 2021 16:45:34 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Fri, 12 Mar 2021 16:45:34 -0800
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=45702)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lKsPO-0004B8-13; Fri, 12 Mar 2021 16:45:34 -0800
Subject: Re: [PATCH V3 XRT Alveo 16/18] fpga: xrt: DDR calibration platform
 driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-17-lizhih@xilinx.com>
 <b77ea263-d368-25d8-409e-7cac2601a967@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <5f0120f4-44ef-7a18-658d-537dcd8d4715@xilinx.com>
Date:   Fri, 12 Mar 2021 16:45:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <b77ea263-d368-25d8-409e-7cac2601a967@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0b56170-b09e-44ed-8333-08d8e5b95046
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3502:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB350257EAB491CC93F20523EAA16E9@SN4PR0201MB3502.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:549;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GzzcfnglsOBIZXANa2Q7UOdj+1k7sD/H3d0NCRWve7/nVUxZcsM+FpiKglPCpPUJAOC+ktxD2xr5wOj4MTQptXmYAHUC9t2b47P1GiNTD7WWZV8bYNWXeBR9p9KoetkpJV0iF/YFWM9yvcrr8EC+DwiifHgKAJ4y2cgFeckA6iFJQ24s2dqS0nrQy1H2FgAfSVZ4TTjo7BiSNs6M57DEP4Yevk0fNA2mMkZx+z0q88Af5BXlbPQPthBvRqLmw6gEKHxakAF9aNj1kG4kc5zX+tbr/G7WPHd8i/r9rbPqafPq/bTQwgUqGsQLUy1feW4UK0uFBT9NKjZdiAG9KVtGyifA442FEWXxJ3T18nRmgMhRrFdI+wApC5w5BEMN3gsVoxFrBbORbhk7mbfPEyi24bWPk+5lrNlA3GARQeblBeoxHjIa5NoZ2g4lQAW673VOyyMPat8/+WenllyjhcNOAKSEyK1iFLv0DFggmXXAZuMQKKkkx188w5wHW3IurE5jlknfWGtYAiyWpm+XHajNXPtqQqhyn6dAVNFaELJCN3Dualq8oVBkg8sMvmQbEJ0DhJ28cUsnIxYsHscAolazkMDFHJmnanZBKpoyBGSFw7+MVtgn+ONkXruTprBzpc87PAJkZltBFuOp4mgyslCca033SdU74zUIWRXZNNHy15T6ckJ5S7chc69Cidss7V7cmdQvv7hJ3m2Rfkp90y8Q7x+etE2dugASiasgdPtPv8M=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(46966006)(36840700001)(110136005)(36906005)(54906003)(44832011)(316002)(8936002)(31686004)(478600001)(356005)(7636003)(426003)(82310400003)(2616005)(8676002)(36756003)(36860700001)(31696002)(9786002)(82740400003)(26005)(47076005)(186003)(5660300002)(2906002)(336012)(83380400001)(107886003)(70206006)(70586007)(4326008)(53546011)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2021 00:45:35.0814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b56170-b09e-44ed-8333-08d8e5b95046
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3502
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 03/06/2021 07:34 AM, Tom Rix wrote:
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> Add DDR calibration driver. DDR calibration is a hardware function
>> discovered by walking firmware metadata. A platform device node will
>> be created for it. Hardware provides DDR calibration status through
>> this function.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/xleaf/calib.h |  30 ++++
>>   drivers/fpga/xrt/lib/xleaf/calib.c     | 226 +++++++++++++++++++++++++
>>   2 files changed, 256 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/calib.h
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/calib.c
> calib is not descriptive, change filename to ddr_calibration
Sure.
>> diff --git a/drivers/fpga/xrt/include/xleaf/calib.h b/drivers/fpga/xrt/include/xleaf/calib.h
>> new file mode 100644
>> index 000000000000..f8aba4594c58
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/xleaf/calib.h
>> @@ -0,0 +1,30 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for XRT DDR Calibration Leaf Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_CALIB_H_
>> +#define _XRT_CALIB_H_
>> +
>> +#include "xleaf.h"
>> +#include <linux/xrt/xclbin.h>
>> +
>> +/*
>> + * Memory calibration driver IOCTL calls.
>> + */
>> +enum xrt_calib_results {
>> +     XRT_CALIB_UNKNOWN,
> Initialize ?
Will fix.
>> +     XRT_CALIB_SUCCEEDED,
>> +     XRT_CALIB_FAILED,
>> +};
>> +
>> +enum xrt_calib_ioctl_cmd {
>> +     XRT_CALIB_RESULT = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
>> +};
>> +
>> +#endif       /* _XRT_CALIB_H_ */
>> diff --git a/drivers/fpga/xrt/lib/xleaf/calib.c b/drivers/fpga/xrt/lib/xleaf/calib.c
>> new file mode 100644
>> index 000000000000..fbb813636e76
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/xleaf/calib.c
>> @@ -0,0 +1,226 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo FPGA memory calibration driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * memory calibration
>> + *
>> + * Authors:
>> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
>> + */
>> +#include <linux/delay.h>
>> +#include "xclbin-helper.h"
>> +#include "metadata.h"
>> +#include "xleaf/calib.h"
>> +
>> +#define XRT_CALIB    "xrt_calib"
>> +
>> +struct calib_cache {
>> +     struct list_head        link;
>> +     const char              *ep_name;
>> +     char                    *data;
>> +     u32                     data_size;
>> +};
>> +
>> +struct calib {
>> +     struct platform_device  *pdev;
>> +     void                    *calib_base;
>> +     struct mutex            lock; /* calibration dev lock */
>> +     struct list_head        cache_list;
>> +     u32                     cache_num;
>> +     enum xrt_calib_results  result;
>> +};
>> +
>> +#define CALIB_DONE(calib)                    \
>> +     (ioread32((calib)->calib_base) & BIT(0))
>> +
>> +static void calib_cache_clean_nolock(struct calib *calib)
>> +{
>> +     struct calib_cache *cache, *temp;
>> +
>> +     list_for_each_entry_safe(cache, temp, &calib->cache_list, link) {
>> +             vfree(cache->data);
>> +             list_del(&cache->link);
>> +             vfree(cache);
>> +     }
>> +     calib->cache_num = 0;
>> +}
>> +
>> +static void calib_cache_clean(struct calib *calib)
>> +{
>> +     mutex_lock(&calib->lock);
>> +     calib_cache_clean_nolock(calib);
> No lock functions (i believe) should be prefixed with '__'
Will change.
>> +     mutex_unlock(&calib->lock);
>> +}
>> +
>> +static int calib_srsr(struct calib *calib, struct platform_device *srsr_leaf)
> what is srsr ?
>
> Why a noop function ?
srsr is save-restore and self-refresh. It will not be supported in this 
patch set. I will remove this function.
>
>> +{
>> +     return -EOPNOTSUPP;
>> +}
>> +
>> +static int calib_calibration(struct calib *calib)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < 20; i++) {
> 20 is a config parameter so should have a #define
>
> There a couple of busy wait blocks in xrt/ some count up, some count down.
>
> It would be good if they were consistent.
Will change these.
>
>> +             if (CALIB_DONE(calib))
>> +                     break;
>> +             msleep(500);
> 500 is another config
Will define.

Thanks,
Lizhi
>
> Tom
>
>> +     }
>> +
>> +     if (i == 20) {
>> +             xrt_err(calib->pdev,
>> +                     "MIG calibration timeout after bitstream download");
>> +             return -ETIMEDOUT;
>> +     }
>> +
>> +     xrt_info(calib->pdev, "took %dms", i * 500);
>> +     return 0;
>> +}
>> +
>> +static void xrt_calib_event_cb(struct platform_device *pdev, void *arg)
>> +{
>> +     struct calib *calib = platform_get_drvdata(pdev);
>> +             struct xrt_event *evt = (struct xrt_event *)arg;
>> +     enum xrt_events e = evt->xe_evt;
>> +     enum xrt_subdev_id id = evt->xe_subdev.xevt_subdev_id;
>> +     int instance = evt->xe_subdev.xevt_subdev_instance;
>> +     struct platform_device *leaf;
>> +     int ret;
>> +
>> +     switch (e) {
>> +     case XRT_EVENT_POST_CREATION: {
>> +             if (id == XRT_SUBDEV_SRSR) {
>> +                     leaf = xleaf_get_leaf_by_id(pdev,
>> +                                                 XRT_SUBDEV_SRSR,
>> +                                                 instance);
>> +                     if (!leaf) {
>> +                             xrt_err(pdev, "does not get SRSR subdev");
>> +                             return;
>> +                     }
>> +                     ret = calib_srsr(calib, leaf);
>> +                     xleaf_put_leaf(pdev, leaf);
>> +                     calib->result =
>> +                             ret ? XRT_CALIB_FAILED : XRT_CALIB_SUCCEEDED;
>> +             } else if (id == XRT_SUBDEV_UCS) {
>> +                     ret = calib_calibration(calib);
>> +                     calib->result =
>> +                             ret ? XRT_CALIB_FAILED : XRT_CALIB_SUCCEEDED;
>> +             }
>> +             break;
>> +     }
>> +     default:
>> +             break;
>> +     }
>> +}
>> +
>> +static int xrt_calib_remove(struct platform_device *pdev)
>> +{
>> +     struct calib *calib = platform_get_drvdata(pdev);
>> +
>> +     calib_cache_clean(calib);
>> +
>> +     if (calib->calib_base)
>> +             iounmap(calib->calib_base);
>> +
>> +     platform_set_drvdata(pdev, NULL);
>> +     devm_kfree(&pdev->dev, calib);
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_calib_probe(struct platform_device *pdev)
>> +{
>> +     struct calib *calib;
>> +     struct resource *res;
>> +     int err = 0;
>> +
>> +     calib = devm_kzalloc(&pdev->dev, sizeof(*calib), GFP_KERNEL);
>> +     if (!calib)
>> +             return -ENOMEM;
>> +
>> +     calib->pdev = pdev;
>> +     platform_set_drvdata(pdev, calib);
>> +
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (!res)
>> +             goto failed;
>> +
>> +     calib->calib_base = ioremap(res->start, res->end - res->start + 1);
>> +     if (!calib->calib_base) {
>> +             err = -EIO;
>> +             xrt_err(pdev, "Map iomem failed");
>> +             goto failed;
>> +     }
>> +
>> +     mutex_init(&calib->lock);
>> +     INIT_LIST_HEAD(&calib->cache_list);
>> +
>> +     return 0;
>> +
>> +failed:
>> +     xrt_calib_remove(pdev);
>> +     return err;
>> +}
>> +
>> +static int
>> +xrt_calib_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
>> +{
>> +     struct calib *calib = platform_get_drvdata(pdev);
>> +     int ret = 0;
>> +
>> +     switch (cmd) {
>> +     case XRT_XLEAF_EVENT:
>> +             xrt_calib_event_cb(pdev, arg);
>> +             break;
>> +     case XRT_CALIB_RESULT: {
>> +             enum xrt_calib_results *r = (enum xrt_calib_results *)arg;
>> +             *r = calib->result;
>> +             break;
>> +     }
>> +     default:
>> +             xrt_err(pdev, "unsupported cmd %d", cmd);
>> +             ret = -EINVAL;
>> +     }
>> +     return ret;
>> +}
>> +
>> +static struct xrt_subdev_endpoints xrt_calib_endpoints[] = {
>> +     {
>> +             .xse_names = (struct xrt_subdev_ep_names[]) {
>> +                     { .ep_name = XRT_MD_NODE_DDR_CALIB },
>> +                     { NULL },
>> +             },
>> +             .xse_min_ep = 1,
>> +     },
>> +     { 0 },
>> +};
>> +
>> +static struct xrt_subdev_drvdata xrt_calib_data = {
>> +     .xsd_dev_ops = {
>> +             .xsd_ioctl = xrt_calib_leaf_ioctl,
>> +     },
>> +};
>> +
>> +static const struct platform_device_id xrt_calib_table[] = {
>> +     { XRT_CALIB, (kernel_ulong_t)&xrt_calib_data },
>> +     { },
>> +};
>> +
>> +static struct platform_driver xrt_calib_driver = {
>> +     .driver = {
>> +             .name = XRT_CALIB,
>> +     },
>> +     .probe = xrt_calib_probe,
>> +     .remove = xrt_calib_remove,
>> +     .id_table = xrt_calib_table,
>> +};
>> +
>> +void calib_leaf_init_fini(bool init)
>> +{
>> +     if (init)
>> +             xleaf_register_driver(XRT_SUBDEV_CALIB, &xrt_calib_driver, xrt_calib_endpoints);
>> +     else
>> +             xleaf_unregister_driver(XRT_SUBDEV_CALIB);
>> +}

