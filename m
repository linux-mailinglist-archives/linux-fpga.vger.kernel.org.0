Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD9F32C88B
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 02:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232588AbhCDAvC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Mar 2021 19:51:02 -0500
Received: from mail-mw2nam12on2057.outbound.protection.outlook.com ([40.107.244.57]:44256
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1385691AbhCCRVV (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 3 Mar 2021 12:21:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR8/fA9d4X2jZuFn+Sgjqc7vtwdxAQwNtkk+Hm2ni4h6z8kD+g9/zb/hJ9BzOvFKBQAbPfHe4ZScE7IXrR/JB+elnrj3TTYOD1wbChqSGWcTwLc/NDpWSGPIX6OC4IbyjG2XEIXSqGK26M1zoE9hQ62q3+vu2O8ch9kJm8UJfqW39O/yGNvt1bseFOlUsj6JH9tOZcLvKiLNBi9Ly5kG/zMkiaz2xXC+asARKF2/elvXIuqtTfxM5LoVpPeUVO/sWHM2wlL57QZOJTeB9ckdFDjoa/JBvgBhoal9f6DX/YsguF423x1qPcNj+tQH9zBbA9P351jhms4+Jw691Ou50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D89DLwXs2WJBLFcD8sdDcw113TqIuMSJPtsF40IWpko=;
 b=FJ738PR/it7Y/pUuuXHtUgLyKPu1wW/PNfuPD0ASn0tOcmMdfNjQj3TTbwlHzEv+H+mKqMYLCUq+rn7kVrhSe2Ff8Ue+VrzhbYMN6MMnbRTD7Kjw5z49dk3Z/BXtR3E6C+526Ssv5ttDzwa2SpbCoK1riiIADYxfwzoFnobyPoX5EGivt9ShgPJpGuOykLFSgeojvcxDFbth2J5K1fxYUhKwPFoRxai3kHL+gLI2cHizdowB6kdwgfwrTW5b+1sszsUt4VnYdJKDaQ6PuMW9oc4/Yj/zBanhGdqgzSRwKGUw0YjjGM2Bz4WsAmS/qiTdPnbmiF7XFnvc2pK0m6CxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D89DLwXs2WJBLFcD8sdDcw113TqIuMSJPtsF40IWpko=;
 b=SbOz7vjuarHmniHrGUr8DRF1/zdGzrTT4+5t2LbxpNQocghiu5io4rP+H2iLTK+M1N/nmgRIUNJmHQlmphJiqGO4Q9BP84gjcSMrCmbHewa34Q8hqegC9y8hLDqgPHnPwC8bRIdYD+qBmWX/7KilR4y7k/sC3CRHvnupYzhyHXg=
Received: from MN2PR04CA0029.namprd04.prod.outlook.com (2603:10b6:208:d4::42)
 by MW4PR02MB7331.namprd02.prod.outlook.com (2603:10b6:303:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Wed, 3 Mar
 2021 17:20:24 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:d4:cafe::d4) by MN2PR04CA0029.outlook.office365.com
 (2603:10b6:208:d4::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Wed, 3 Mar 2021 17:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Wed, 3 Mar 2021 17:20:24 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 3 Mar 2021 09:20:22 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 3 Mar 2021 09:20:22 -0800
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
Received: from [10.17.3.3] (port=46740)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <max.zhen@xilinx.com>)
        id 1lHVAc-0007cO-Qw; Wed, 03 Mar 2021 09:20:22 -0800
Subject: Re: [PATCH V3 XRT Alveo 04/18] fpga: xrt: xrt-lib platform driver
 manager
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-5-lizhih@xilinx.com>
 <b93fb3ad-bbde-81db-d448-72fb8049f323@redhat.com>
From:   Max Zhen <max.zhen@xilinx.com>
Message-ID: <929c4784-167e-673b-0543-400cf2311a1a@xilinx.com>
Date:   Wed, 3 Mar 2021 09:20:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <b93fb3ad-bbde-81db-d448-72fb8049f323@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29c4c332-aa75-489f-ec84-08d8de68a1a0
X-MS-TrafficTypeDiagnostic: MW4PR02MB7331:
X-Microsoft-Antispam-PRVS: <MW4PR02MB733144B43FBF2E7B4F9E062FB9989@MW4PR02MB7331.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 59AzRKbat8bqTzfmQrlUTqwv67TVvRjz9LSjWl4H8WX+O+JKCjXNJ6+59/0djhQUNxTqbTfEbBgL86/1lwuE+s0l9Cc9woHuUVuNdtKn/qT4+dmCHfeh51s3YASb0ic0yv0qgmDsTRf3usCdd8bbOTjYrcds1SgFa9ezlCU8qr3zfTV6lVJxLVqi2GTiE5uMjp8mKdzzocVOziskHQ5f6ss0yUf0hK8+gbQuRAozSXkS+wH355VTCuDdlhGSrbRJAsNsjqhLd3CD2yHugzDp5iTXCpa+9ocg9FEzl3mhEQb/9Mpy3bJX1+SmmSM88OzChwK6k+ynaYiuXhznbGeJ2MGpT7N+Bgwr+eKvmyt0k1ZojHf8/fqe0dCGXdQUw5WnfTM96rkUS+2bpnv/mwllOkQEMjGtgiRgGMXGtiWhptAMkXaOnxxQHwP6LccN1DT16l89QREBtSp4r0FDuiNcmHQuDsQuReLmUzForpytdTvxAgmPQ8+78jKIyXQq8ue4A6ukbyjISgNHDxUpvM6nOUjxLww8vyVHAgku03+9IqOL2Nh4jXQ4+Ykv0pMZVkq13CYYwZi5d393H9X60GMXtC9942vkSV35F/N1GvbbJjC+8nE0OFpFLX6dNc52dwMdascmUOuKvJyYHUf/zDLmUnEfPtkXiVI3a3l4oNjhq0bKyLPfK69cLSV+3Cjuk0VqWxTUfmvADDs9R/4iBrBiBngduJ6/P8WPhJn/JP4AsLU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966006)(36840700001)(53546011)(356005)(82740400003)(7636003)(44832011)(70206006)(426003)(107886003)(47076005)(54906003)(110136005)(26005)(31696002)(36860700001)(5660300002)(82310400003)(31686004)(30864003)(336012)(316002)(186003)(4326008)(36906005)(478600001)(83380400001)(8676002)(70586007)(2906002)(2616005)(9786002)(36756003)(8936002)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2021 17:20:24.1125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c4c332-aa75-489f-ec84-08d8de68a1a0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7331
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/22/21 7:05 AM, Tom Rix wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
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
> Not sure if 'main' is a good base name for something going into a lib.


These files are the main file for xrt-lib.ko. I'm not sure what name you 
prefer, but I've changed them to lib-drv.[c|h]. Let me know if you don't 
like them...


>
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
> by it's ID


Sure.


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
> name could be by convention
>
> __xrt_drv_find_map_id


Sure.


>
>> +{
>> +     const struct list_head *ptr;
>> +
>> +     list_for_each(ptr, &xrt_drv_maps) {
>> +             struct xrt_drv_map *tmap = list_entry(ptr, struct xrt_drv_map, list);
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
> even after the lock


Sure.


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
> Trying to minimize length of lock being held.
>
> Could holding this lock be split or the alloc moved above ?


We don't want to do memory allocation unless the mapping can't be found. 
So, finding the mapping and allocating memory for new entry is done as 
one atomic operation.

The code path here is far from being in critical path, so holding a lock 
here for some longer time should not be a problem. I'd like to keep the 
code straightforward and easy to follow by holding the lock from start 
to end.


>
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
> general issue
>
> map is small, so kzalloc


Sure.


>> +     if (!map) {
>> +             mutex_unlock(&xrt_lib_lock);
>> +             return -ENOMEM;
>> +     }
>> +     map->id = id;
>> +     map->drv = drv;
>> +     map->eps = eps;
>> +
>> +     xrt_drv_register_driver(map);
> xrt_drv_register_driver failure is unhandled.


Sure.


>
> This is the only time xrt_drv_register_driver is called, consider expanding the function here and removing the call.


Expanding the function here will result in > 3 level of indentation, 
which is bad. I'd like to keep it as a function.


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
> These constructor/destructor calls needs to be more dynamic.
>
> calls are made even if there are no subdevices to go with the id's.
>
> Also this list can not grow.  How would a new id be added by a module ?


We do not support dynamically adding drivers/IDs. All drivers needs to 
be added statically after thoroughly tested. We do not intend to build 
an open infrastructure to support random hardware and driver anyway.


>
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
> To be self contained, the header defining enum xrt_subdev_id should be included.
>
> This is subdev_id.h which comes in with patch 6
>
> A dependency on a future patch breaks bisectablity.
>
> It may make sense to collect these small headers into a single large header for the ip infra lib and bring them all in this patch.


Yes, we will reconsider where to put these headers in next patch set.

Thanks,

Max


>
> Tom
>
>> +int xrt_drv_get_instance(enum xrt_subdev_id id);
>> +void xrt_drv_put_instance(enum xrt_subdev_id id, int instance);
>> +struct xrt_subdev_endpoints *xrt_drv_get_endpoints(enum xrt_subdev_id id);
>> +
>> +#endif       /* _XRT_MAIN_H_ */
