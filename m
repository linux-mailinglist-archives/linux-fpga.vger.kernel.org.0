Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8AD329231
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Mar 2021 21:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242585AbhCAUk6 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Mar 2021 15:40:58 -0500
Received: from mail-dm6nam08on2085.outbound.protection.outlook.com ([40.107.102.85]:55008
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242605AbhCAUfB (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 1 Mar 2021 15:35:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCXGVC8t0Rowj7kkbj416lObZmTooVA/1kcs071GHzDvBxp1R5cdQcGQa/ov357gDkuHqAX0ovkFZScX7gndB0ZZUFzWBsyfrqjbfzm8BlC09RvyP8B4owi7tqw84PZ3a/dw0bUCTfAxN3SE4FooglU2y22ph6XvXDRKh6uPXpEICnXFlzGPcg3U6kdh4oE8/0pjEjY3bvD0OwF20CygvwKow1BQC6ayAngjg3dzojV8UW9v+2K6hzGwoluIIW15aQJ4dX0pBrNH+OP8kPFGbxOS2K/XfC8QNVPP4dIvai0XzixRvj25+Sq0YSxTtFhPmKpnuARknyYhJgDWyjDJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur40ZnzWXzXq18CfkA2dMWoulJfon8WuAoZ29X1RobE=;
 b=U4TfHEE2nPvBahdx7mwA2/RAcYvsAythHZRNkeC8yHrQXR1lMNqUeHaG2x+oW+F/ea1RfQRELDZesjQ1D2bShpGSGIvsxxy9r1/lLtfeUoZSrxdY1QQdvJgZ2dHyRYa/GMFqM6iU6QIJLif8mg//HqSKQXHKQ5HAv2ubL1HmF+QNn41nn8tQkvRe8gWqjI1L2eQXnKovhPLfM2V8bFpPYCdeSsAEnf7ssfxqK+yXx3C6ymAEwftrn6xwKlskvSU0jNlPVTnHJnVlRzhXYg8g7nR+V8a2vtpmKYrT2BbroJCHvA3hTTwxY4INNXMR15lRW2QEXMetfkoMyMNlimWO2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ur40ZnzWXzXq18CfkA2dMWoulJfon8WuAoZ29X1RobE=;
 b=P0OQnpg//gxRPUWDGNwkUKaoZ8Pgwz34scD/ZEJ5zs9tAJjjkCwyn0qqi+HCynuQM0k1IBH8AwuDTFT3zUfOGMktMjdmwjb0Y1HN6Er+k/u/vVrZ239ib5NhpSPKDuSpl+L5NP986unVVJauSTjnvv/3469XpV+li3RNIKnHoHM=
Received: from CY4PR22CA0033.namprd22.prod.outlook.com (2603:10b6:903:ed::19)
 by BN7PR02MB3972.namprd02.prod.outlook.com (2603:10b6:406:ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Mon, 1 Mar
 2021 20:34:06 +0000
Received: from CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:ed:cafe::99) by CY4PR22CA0033.outlook.office365.com
 (2603:10b6:903:ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend
 Transport; Mon, 1 Mar 2021 20:34:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT035.mail.protection.outlook.com (10.152.75.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Mon, 1 Mar 2021 20:34:05 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 1 Mar 2021 12:34:02 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Mon, 1 Mar 2021 12:34:02 -0800
Envelope-to: max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 lizhi.hou@xilinx.com,
 stefanos@xilinx.com,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 mdf@kernel.org
Received: from [10.17.3.3] (port=37834)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <max.zhen@xilinx.com>)
        id 1lGpEw-0007wW-41; Mon, 01 Mar 2021 12:34:02 -0800
Subject: Re: [PATCH V3 XRT Alveo 04/18] fpga: xrt: xrt-lib platform driver
 manager
To:     Moritz Fischer <mdf@kernel.org>, Lizhi Hou <lizhi.hou@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, Lizhi Hou <lizhih@xilinx.com>,
        <linux-fpga@vger.kernel.org>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <robh@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-5-lizhih@xilinx.com> <YDLFDpJ4STer/yKx@archbook>
From:   Max Zhen <max.zhen@xilinx.com>
Message-ID: <322bc5f3-902a-8b8a-ae56-9cd657ab9b0f@xilinx.com>
Date:   Mon, 1 Mar 2021 12:34:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <YDLFDpJ4STer/yKx@archbook>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f116fc43-754d-4f6b-dc09-08d8dcf15b99
X-MS-TrafficTypeDiagnostic: BN7PR02MB3972:
X-Microsoft-Antispam-PRVS: <BN7PR02MB3972320142F122CDDA8312B8B99A9@BN7PR02MB3972.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P6FFWurBYHRawleJZZUxT2v/kshAyQzh7jiPbN6K2E2vDK6Rj3u26jm0sO+WlqYiCYZ8bJO9sAl09JIzl1IKYNpnUKLGVgdbYd2zcJVYdySOEf+GoLhcDlMVhkIoxmWNYgQ8LZd4hpCRG+WtkuvEvnKkOpdMV8sg4A2W83SbC8lXXqtXAvggUW0B6dX+UlDNbsLFvTdcrAfmDP72DkusN0QL1PDXrpgdz4jzROWdswMjadYA90GkMsLNBMNvbkwc+LEUghNoyHvhCYWbDmweZLLCz+ruQc9Plz76wJTCPONsYXngZ8OLPYW8O5Uk+FKG22pLcNuxOPqIrxCjY73yR0mTIjXYGPyu57N3rohGuv5rnpDEwUd1DoDVv67atHuDXLBxQn1y3qwbFElRG9jn1Xfylegk4732pvyiLLm2FRqRAkPYEVz14+mVOweT88z34xR8pfCyR3k1NPx1ogdSZB+uK04gSxZaYkUL3VUk0qBfFqKlFJK2h90BUce5ZX4o3GzsZWY9v8vatC86Q1w+AS+NcDCSFbM/kGhPHDIgJiNLTuQUvrOsapMmMtsEzDTgvszNJe1LcoglGAeawARgxg2qbP+yV8KPpcyJ4Kap+73z355Egi2AHKy5yqkSqSOlPwUfuc1nBGhAaNUO2hm8FIqcKhcTOmbzQjM74D+YSd95M+9ecfkDMzM/lLfhXeVSPic/6Fv7CfOnHLRmBVjJqA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(36840700001)(46966006)(6636002)(9786002)(2616005)(426003)(82310400003)(186003)(70586007)(8936002)(8676002)(70206006)(26005)(336012)(4326008)(2906002)(36756003)(82740400003)(7636003)(5660300002)(478600001)(36860700001)(36906005)(107886003)(356005)(31696002)(31686004)(44832011)(54906003)(47076005)(53546011)(110136005)(316002)(83380400001)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 20:34:05.4324
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f116fc43-754d-4f6b-dc09-08d8dcf15b99
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT035.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB3972
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Moritz,


On 2/21/21 12:39 PM, Moritz Fischer wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> Lizhi,
>
> On Wed, Feb 17, 2021 at 10:40:05PM -0800, Lizhi Hou wrote:
>> xrt-lib kernel module infrastructure code to register and manage all
>> leaf driver modules.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/lib/main.c | 274 ++++++++++++++++++++++++++++++++++++
>>   drivers/fpga/xrt/lib/main.h |  17 +++
>>   2 files changed, 291 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/lib/main.c
>>   create mode 100644 drivers/fpga/xrt/lib/main.h
>>
>> diff --git a/drivers/fpga/xrt/lib/main.c b/drivers/fpga/xrt/lib/main.c
>> new file mode 100644
>> index 000000000000..36fb62710843
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/main.c
>> @@ -0,0 +1,274 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for Xilinx Alveo FPGA Support
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#include <linux/module.h>
>> +#include "xleaf.h"
>> +#include "xroot.h"
>> +#include "main.h"
>> +
>> +#define XRT_IPLIB_MODULE_NAME                "xrt-lib"
>> +#define XRT_IPLIB_MODULE_VERSION     "4.0.0"
>> +#define XRT_MAX_DEVICE_NODES         128
>> +#define XRT_DRVNAME(drv)             ((drv)->driver.name)
>> +
>> +/*
>> + * Subdev driver is known by ID to others. We map the ID to it's
>> + * struct platform_driver, which contains it's binding name and driver/file ops.
>> + * We also map it to the endpoint name in DTB as well, if it's different
>> + * than the driver's binding name.
>> + */
>> +struct xrt_drv_map {
>> +     struct list_head list;
>> +     enum xrt_subdev_id id;
>> +     struct platform_driver *drv;
>> +     struct xrt_subdev_endpoints *eps;
>> +     struct ida ida; /* manage driver instance and char dev minor */
>> +};
>> +
>> +static DEFINE_MUTEX(xrt_lib_lock); /* global lock protecting xrt_drv_maps list */
>> +static LIST_HEAD(xrt_drv_maps);
>> +struct class *xrt_class;
>> +
>> +static inline struct xrt_subdev_drvdata *
>> +xrt_drv_map2drvdata(struct xrt_drv_map *map)
>> +{
>> +     return (struct xrt_subdev_drvdata *)map->drv->id_table[0].driver_data;
>> +}
>> +
>> +static struct xrt_drv_map *
>> +xrt_drv_find_map_by_id_nolock(enum xrt_subdev_id id)
>> +{
>> +     const struct list_head *ptr;
>> +
>> +     list_for_each(ptr, &xrt_drv_maps) {
>> +             struct xrt_drv_map *tmap = list_entry(ptr, struct xrt_drv_map, list);
> list_for_each_entry, maybe?


Yes!


>> +
>> +             if (tmap->id == id)
>> +                     return tmap;
>> +     }
>> +     return NULL;
>> +}
>> +
>> +static struct xrt_drv_map *
>> +xrt_drv_find_map_by_id(enum xrt_subdev_id id)
>> +{
>> +     struct xrt_drv_map *map;
>> +
>> +     mutex_lock(&xrt_lib_lock);
>> +     map = xrt_drv_find_map_by_id_nolock(id);
>> +     mutex_unlock(&xrt_lib_lock);
>> +     /*
>> +      * map should remain valid even after lock is dropped since a registered
>> +      * driver should only be unregistered when driver module is being unloaded,
>> +      * which means that the driver should not be used by then.
>> +      */
>> +     return map;
>> +}
>> +
>> +static int xrt_drv_register_driver(struct xrt_drv_map *map)
>> +{
>> +     struct xrt_subdev_drvdata *drvdata;
>> +     int rc = 0;
>> +     const char *drvname = XRT_DRVNAME(map->drv);
>> +
>> +     rc = platform_driver_register(map->drv);
>> +     if (rc) {
>> +             pr_err("register %s platform driver failed\n", drvname);
>> +             return rc;
>> +     }
>> +
>> +     drvdata = xrt_drv_map2drvdata(map);
>> +     if (drvdata) {
>> +             /* Initialize dev_t for char dev node. */
>> +             if (xleaf_devnode_enabled(drvdata)) {
>> +                     rc = alloc_chrdev_region(&drvdata->xsd_file_ops.xsf_dev_t, 0,
>> +                                              XRT_MAX_DEVICE_NODES, drvname);
>> +                     if (rc) {
>> +                             platform_driver_unregister(map->drv);
>> +                             pr_err("failed to alloc dev minor for %s: %d\n", drvname, rc);
>> +                             return rc;
>> +                     }
>> +             } else {
>> +                     drvdata->xsd_file_ops.xsf_dev_t = (dev_t)-1;
>> +             }
>> +     }
>> +
>> +     ida_init(&map->ida);
>> +
>> +     pr_info("%s registered successfully\n", drvname);
> Is this not xrt_info() then?


xrt_info() is meant for leaf driver to call where struct platform_device 
is available. We are initializing the drivers here, so can't call 
xrt_info().


>> +
>> +     return 0;
>> +}
>> +
>> +static void xrt_drv_unregister_driver(struct xrt_drv_map *map)
>> +{
>> +     const char *drvname = XRT_DRVNAME(map->drv);
>> +     struct xrt_subdev_drvdata *drvdata;
>> +
>> +     ida_destroy(&map->ida);
>> +
>> +     drvdata = xrt_drv_map2drvdata(map);
>> +     if (drvdata && drvdata->xsd_file_ops.xsf_dev_t != (dev_t)-1) {
>> +             unregister_chrdev_region(drvdata->xsd_file_ops.xsf_dev_t,
>> +                                      XRT_MAX_DEVICE_NODES);
>> +     }
>> +
>> +     platform_driver_unregister(map->drv);
>> +
>> +     pr_info("%s unregistered successfully\n", drvname);
>> +}
>> +
>> +int xleaf_register_driver(enum xrt_subdev_id id,
>> +                       struct platform_driver *drv,
>> +                       struct xrt_subdev_endpoints *eps)
>> +{
>> +     struct xrt_drv_map *map;
>> +
>> +     mutex_lock(&xrt_lib_lock);
>> +
>> +     map = xrt_drv_find_map_by_id_nolock(id);
>> +     if (map) {
>> +             mutex_unlock(&xrt_lib_lock);
>> +             pr_err("Id %d already has a registered driver, 0x%p\n",
>> +                    id, map->drv);
>> +             return -EEXIST;
>> +     }
>> +
>> +     map = vzalloc(sizeof(*map));
>> +     if (!map) {
>> +             mutex_unlock(&xrt_lib_lock);
>> +             return -ENOMEM;
>> +     }
>> +     map->id = id;
>> +     map->drv = drv;
>> +     map->eps = eps;
>> +
>> +     xrt_drv_register_driver(map);
>> +
>> +     list_add(&map->list, &xrt_drv_maps);
>> +
>> +     mutex_unlock(&xrt_lib_lock);
>> +
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_register_driver);
>> +
>> +void xleaf_unregister_driver(enum xrt_subdev_id id)
>> +{
>> +     struct xrt_drv_map *map;
>> +
>> +     mutex_lock(&xrt_lib_lock);
>> +
>> +     map = xrt_drv_find_map_by_id_nolock(id);
>> +     if (!map) {
>> +             mutex_unlock(&xrt_lib_lock);
>> +             pr_err("Id %d has no registered driver\n", id);
>> +             return;
>> +     }
>> +
>> +     list_del(&map->list);
>> +
>> +     mutex_unlock(&xrt_lib_lock);
>> +
>> +     xrt_drv_unregister_driver(map);
>> +     vfree(map);
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_unregister_driver);
>> +
>> +const char *xrt_drv_name(enum xrt_subdev_id id)
>> +{
>> +     struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
>> +
>> +     if (map)
>> +             return XRT_DRVNAME(map->drv);
>> +     return NULL;
>> +}
>> +
>> +int xrt_drv_get_instance(enum xrt_subdev_id id)
>> +{
>> +     struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
>> +
>> +     return ida_alloc_range(&map->ida, 0, XRT_MAX_DEVICE_NODES, GFP_KERNEL);
>> +}
>> +
>> +void xrt_drv_put_instance(enum xrt_subdev_id id, int instance)
>> +{
>> +     struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
>> +
>> +     ida_free(&map->ida, instance);
>> +}
>> +
>> +struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id)
>> +{
>> +     struct xrt_drv_map *map = xrt_drv_find_map_by_id(id);
>> +     struct xrt_subdev_endpoints *eps;
>> +
>> +     eps = map ? map->eps : NULL;
>> +     return eps;
>> +}
>> +
>> +/* Leaf driver's module init/fini callbacks. */
>> +static void (*leaf_init_fini_cbs[])(bool) = {
>> +     group_leaf_init_fini,
>> +     vsec_leaf_init_fini,
>> +     devctl_leaf_init_fini,
>> +     axigate_leaf_init_fini,
>> +     icap_leaf_init_fini,
>> +     calib_leaf_init_fini,
>> +     clkfreq_leaf_init_fini,
>> +     clock_leaf_init_fini,
>> +     ucs_leaf_init_fini,
>> +};
>> +
>> +static __init int xrt_lib_init(void)
>> +{
>> +     int i;
>> +
>> +     xrt_class = class_create(THIS_MODULE, XRT_IPLIB_MODULE_NAME);
>> +     if (IS_ERR(xrt_class))
>> +             return PTR_ERR(xrt_class);
>> +
>> +     for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
>> +             leaf_init_fini_cbs[i](true);
>> +     return 0;
>> +}
>> +
>> +static __exit void xrt_lib_fini(void)
>> +{
>> +     struct xrt_drv_map *map;
>> +     int i;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
>> +             leaf_init_fini_cbs[i](false);
>> +
>> +     mutex_lock(&xrt_lib_lock);
>> +
>> +     while (!list_empty(&xrt_drv_maps)) {
>> +             map = list_first_entry_or_null(&xrt_drv_maps, struct xrt_drv_map, list);
>> +             pr_err("Unloading module with %s still registered\n", XRT_DRVNAME(map->drv));
>> +             list_del(&map->list);
>> +             mutex_unlock(&xrt_lib_lock);
>> +             xrt_drv_unregister_driver(map);
>> +             vfree(map);
>> +             mutex_lock(&xrt_lib_lock);
>> +     }
>> +
>> +     mutex_unlock(&xrt_lib_lock);
>> +
>> +     class_destroy(xrt_class);
>> +}
>> +
>> +module_init(xrt_lib_init);
>> +module_exit(xrt_lib_fini);
>> +
>> +MODULE_VERSION(XRT_IPLIB_MODULE_VERSION);
>> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
>> +MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/fpga/xrt/lib/main.h b/drivers/fpga/xrt/lib/main.h
>> new file mode 100644
>> index 000000000000..f3bfc87ee614
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/main.h
>> @@ -0,0 +1,17 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_MAIN_H_
>> +#define _XRT_MAIN_H_
>> +
>> +const char *xrt_drv_name(enum xrt_subdev_id id);
>> +int xrt_drv_get_instance(enum xrt_subdev_id id);
>> +void xrt_drv_put_instance(enum xrt_subdev_id id, int instance);
>> +struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id);
>> +
>> +#endif       /* _XRT_MAIN_H_ */
>> --
>> 2.18.4
>>
> This smells like it should be a bus to me...


This is discussed in another email thread. I will not add more comment here.

Thanks,

Max


>
> - Moritz
