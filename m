Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C826358AF2
	for <lists+linux-fpga@lfdr.de>; Thu,  8 Apr 2021 19:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhDHRKF (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 8 Apr 2021 13:10:05 -0400
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:32672
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232631AbhDHRKE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 8 Apr 2021 13:10:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/CMbDaF4GwclbdFI7WK980+KIVbII3f43Gt/KBw98y7vOqNCea5pnsC+PPID6To+mXYnT4QANuCv9tvzhtotJynVEdUBt0SybT0wChGarpBOZr7Rkx3vM/eTUOYh0aRCsVJrJxZr4JZXBXMTU/XWDHsnWPv0u83h3h5crbxhBC9NYE3B69JHjMfElJcuOyyte9tx3pfNpu2AX/1HARJQq8Z+Nkxoudm58k1OkVgBxzP35HM0nmK6qsAloP4M+B37GrWvxjeJMcP5TMJZIeQvq254VVFPBUtDcm37KjR9ymOUqV+zQZPv3kRBsFsTiLJn85h/QZhJWvkcLUhGp6WQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNCAyGjGc9c4+rhTJ9o0XYbj9tegQ6burj0EaX0Q6do=;
 b=deCIfYnncYjLcCE4h3egwEaDZpBYVoGQHp8cGMaMwgJMq/8gHSJxgZAjTz/GFeKl5Ax3nCAf3sYP9IA3kvpggg/ZP3G3EjSO17wDF/5nmz1ieE2XyB7B+BJ3W51yAzDge+EDxHjIe7aWglPb1qlW9MYgxcVn+zzqr4Xa0yyAIuEnXlDIxKhbpR6cFNRf5pGAG2gJ6KJ9ccck8BY6ubs9KsjV4Hb9x7umm4Xvc3zqrBWBvDtj98wcqhTSa13LuEbiQ17QNHTq+jAhDMxCmAAUVvjJ2zcp1PRGeIqdUnm4eActOhpnmENrIlrEckdfH61RA++fmvOfcx2cN6dVH1Rcvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oNCAyGjGc9c4+rhTJ9o0XYbj9tegQ6burj0EaX0Q6do=;
 b=HAysj+15DUN/faVjXhxnpwYDVq5770BkRkscQJl6iBCbHwqseDWEwtF9CQBXsKffnjxSOkikHeKYRiJicVkHu6yJe2p2cwZUgMsds2ZcV+s8+YvbW3CESVDgttasXSfVarCzI7+pYCmmzn4YCMnjKMfZla/ceB0QRMCOh0uQfOM=
Received: from DM5PR07CA0132.namprd07.prod.outlook.com (2603:10b6:3:13e::22)
 by CY4PR02MB2374.namprd02.prod.outlook.com (2603:10b6:903:d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 8 Apr
 2021 17:09:50 +0000
Received: from DM3NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:13e:cafe::be) by DM5PR07CA0132.outlook.office365.com
 (2603:10b6:3:13e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.19 via Frontend
 Transport; Thu, 8 Apr 2021 17:09:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT006.mail.protection.outlook.com (10.13.4.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4020.17 via Frontend Transport; Thu, 8 Apr 2021 17:09:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 10:09:46 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Thu, 8 Apr 2021 10:09:46 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.3.3] (port=58634)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <max.zhen@xilinx.com>)
        id 1lUYA6-0004nq-8R; Thu, 08 Apr 2021 10:09:46 -0700
From:   Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V4 XRT Alveo 08/20] fpga: xrt: platform driver
 infrastructure
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <sonal.santan@xilinx.com>,
        <yliu@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-9-lizhi.hou@xilinx.com>
 <c87f0573-8eeb-1734-bceb-42648d404acf@redhat.com>
Message-ID: <07419fb1-8843-dac9-4423-7419c36115e9@xilinx.com>
Date:   Thu, 8 Apr 2021 10:09:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <c87f0573-8eeb-1734-bceb-42648d404acf@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8649e637-0756-4848-4696-08d8fab11e8c
X-MS-TrafficTypeDiagnostic: CY4PR02MB2374:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2374689AC4A8A78B1E64392DB9749@CY4PR02MB2374.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HSX6jFdZOBBOaGFdF1O1oZl+EU6QihJHw6hzB+Wstyg/pSY6wgoqj+JaUtaoMVKYxFUDsmiwAO3ftwn3MmQqJOIz3eSyUMBDS5XUykEbhWnQFZ/75mapy3HwXcat7tu6lYWCaAVFRq0LGHJToWthNKdb2PXW1JiYVkEysd9nSjuaxOt1IKFfl6HZuuNGtES4D1+KFt4GL7Ag9ZNihBg7KFDyvGSAohXrSaCh/kgTcRuszzHs/U3O9AbqhogsBOaLEfsQlX1pdXuUSFqC/utJuiMa7ZmjhPGYHOei7mJ/5+kIfx1uF5E21w1dvyh668DsgVtEa5sIaY7jfFEiyL1hB4rvrtl0iFT0ETxLSiGLMf9237FIYc+JB/QXgGi4G2TikgXYvoKHj3KuWVcmbC4kHBfIhxnmOKwel53p/pqZOVb0rM5+6czw2ObqU7ZVL6bnH6UpZs6Yof/ArNFVSCSTIIAxBveOzhOV22ajKr4TAUTIKtUxH747mgo0+eIyX6ViqXfnPHn50mXIya0caTZmpubhFqZvw0kGW1/ytN6fj5StAwgwmqzKbXaprl/qT24tY5QCLF2stkbwj/OmpVPtbXycWa6xqcIHW/676u6xIAW8dxwhKgveGMQUZYGFxkFYKQVGTrN2Hupg8lne5c3YohUcglrP0eGMDC585ouro/3YGPQrMEHv5pT2IvfUXNWcTJqR02iXe0nUQrnq0Tb6ii4b2zZgtmJJ4d0NjRET9Jc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(36840700001)(46966006)(5660300002)(30864003)(356005)(31696002)(478600001)(47076005)(36860700001)(4326008)(82310400003)(70206006)(70586007)(83380400001)(53546011)(8936002)(26005)(54906003)(36756003)(107886003)(316002)(186003)(2906002)(336012)(426003)(2616005)(9786002)(44832011)(8676002)(110136005)(82740400003)(36906005)(31686004)(7636003)(50156003)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 17:09:50.0680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8649e637-0756-4848-4696-08d8fab11e8c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2374
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 3/31/21 5:50 AM, Tom Rix wrote:
> Several just for debugging items, consider adding a CONFIG_XRT_DEBUGGING


I'd like to clarify what "only for debugging" means here. It actually 
means that the content of the msg/output only makes sense to a 
developer, v.s. end user. It does not mean that only developer will ever 
execute this code path which triggers the debugging code.

We have msg from print functions like this, and we have output from 
sysfs node like this. We can't just disable all of them by default 
because the content only makes sense to a developer. In some cases, 
requiring a recompilation of the driver to enable the debugging code is 
very difficult to do. E.g., when we need to debug a customer issue and 
we do not have access to the system. It's a big ask for our customer to 
recompile, reload the driver and reproduce the issue for us (v.s. just 
collect and send us the msg/output).


> On 3/23/21 10:29 PM, Lizhi Hou wrote:
>> Infrastructure code providing APIs for managing leaf driver instance
>> groups, facilitating inter-leaf driver calls and root calls.
>>
>> Signed-off-by: Sonal Santan<sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen<max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou<lizhi.hou@xilinx.com>
>> ---
>>   drivers/fpga/xrt/lib/subdev.c | 865 ++++++++++++++++++++++++++++++++++
>>   1 file changed, 865 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/lib/subdev.c
>>
>> diff --git a/drivers/fpga/xrt/lib/subdev.c b/drivers/fpga/xrt/lib/subdev.c
>> new file mode 100644
>> index 000000000000..6428b183fee3
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/subdev.c
>> @@ -0,0 +1,865 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Cheng Zhen<maxz@xilinx.com>
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/pci.h>
>> +#include <linux/vmalloc.h>
>> +#include "xleaf.h"
>> +#include "subdev_pool.h"
>> +#include "lib-drv.h"
>> +#include "metadata.h"
>> +
>> +#define IS_ROOT_DEV(dev) ((dev)->bus == &pci_bus_type)
> for readablity, add a new line here


Will do.


>> +static inline struct device *find_root(struct platform_device *pdev)
>> +{
>> +     struct device *d = DEV(pdev);
>> +
>> +     while (!IS_ROOT_DEV(d))
>> +             d = d->parent;
>> +     return d;
>> +}
>> +
>> +/*
>> + * It represents a holder of a subdev. One holder can repeatedly hold a subdev
>> + * as long as there is a unhold corresponding to a hold.
>> + */
>> +struct xrt_subdev_holder {
>> +     struct list_head xsh_holder_list;
>> +     struct device *xsh_holder;
>> +     int xsh_count;
>> +     struct kref xsh_kref;
>> +};
>> +
>> +/*
>> + * It represents a specific instance of platform driver for a subdev, which
>> + * provides services to its clients (another subdev driver or root driver).
>> + */
>> +struct xrt_subdev {
>> +     struct list_head xs_dev_list;
>> +     struct list_head xs_holder_list;
>> +     enum xrt_subdev_id xs_id;               /* type of subdev */
>> +     struct platform_device *xs_pdev;        /* a particular subdev inst */
>> +     struct completion xs_holder_comp;
>> +};
>> +
>> +static struct xrt_subdev *xrt_subdev_alloc(void)
>> +{
>> +     struct xrt_subdev *sdev = kzalloc(sizeof(*sdev), GFP_KERNEL);
> ok
>> +
>> +     if (!sdev)
>> +             return NULL;
>> +
>> +     INIT_LIST_HEAD(&sdev->xs_dev_list);
>> +     INIT_LIST_HEAD(&sdev->xs_holder_list);
>> +     init_completion(&sdev->xs_holder_comp);
>> +     return sdev;
>> +}
>> +
>> +static void xrt_subdev_free(struct xrt_subdev *sdev)
>> +{
>> +     kfree(sdev);
> Abstraction for a single function is not needed, use kfree directly.


Will do.


>> +}
>> +
>> +int xrt_subdev_root_request(struct platform_device *self, u32 cmd, void *arg)
>> +{
>> +     struct device *dev = DEV(self);
>> +     struct xrt_subdev_platdata *pdata = DEV_PDATA(self);
>> +
>> +     WARN_ON(!pdata->xsp_root_cb);
> ok
>> +     return (*pdata->xsp_root_cb)(dev->parent, pdata->xsp_root_cb_arg, cmd, arg);
>> +}
>> +
>> +/*
>> + * Subdev common sysfs nodes.
>> + */
>> +static ssize_t holders_show(struct device *dev, struct device_attribute *attr, char *buf)
>> +{
>> +     ssize_t len;
>> +     struct platform_device *pdev = to_platform_device(dev);
>> +     struct xrt_root_get_holders holders = { pdev, buf, 1024 };
> Since 1024 is config, #define it somewhere so it can be tweeked later


Will do.


>> +
>> +     len = xrt_subdev_root_request(pdev, XRT_ROOT_GET_LEAF_HOLDERS, &holders);
>> +     if (len >= holders.xpigh_holder_buf_len)
>> +             return len;
>> +     buf[len] = '\n';
>> +     return len + 1;
>> +}
>> +static DEVICE_ATTR_RO(holders);
>> +
>> +static struct attribute *xrt_subdev_attrs[] = {
>> +     &dev_attr_holders.attr,
>> +     NULL,
>> +};
>> +
>> +static ssize_t metadata_output(struct file *filp, struct kobject *kobj,
>> +                            struct bin_attribute *attr, char *buf, loff_t off, size_t count)
>> +{
>> +     struct device *dev = kobj_to_dev(kobj);
>> +     struct platform_device *pdev = to_platform_device(dev);
>> +     struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
>> +     unsigned char *blob;
>> +     unsigned long  size;
>> +     ssize_t ret = 0;
>> +
>> +     blob = pdata->xsp_dtb;
>> +     size = xrt_md_size(dev, blob);
>> +     if (size == XRT_MD_INVALID_LENGTH) {
>> +             ret = -EINVAL;
>> +             goto failed;
>> +     }
>> +
>> +     if (off >= size)
>> +             goto failed;
> if this and next are used for debugging, add a 'dev_dbg()' to help out the debugging.


Will do.


>> +
>> +     if (off + count > size)
>> +             count = size - off;
>> +     memcpy(buf, blob + off, count);
>> +
>> +     ret = count;
>> +failed:
>> +     return ret;
>> +}
>> +
>> +static struct bin_attribute meta_data_attr = {
>> +     .attr = {
>> +             .name = "metadata",
>> +             .mode = 0400
>> +     },
> Permissions will not be enough, anyone can be root.
>
> A developer only interface should be hidden behind a CONFIG_


Please see my comment at the beginning of this reply. Leaving it here 
will ease the trouble shooting on customers system. Further more, 
whoever is root has already gained access to these meta data. So, there 
is also no security concern here for root users to also read it from 
this sysfs node.


>> +     .read = metadata_output,
>> +     .size = 0
>> +};
>> +
>> +static struct bin_attribute  *xrt_subdev_bin_attrs[] = {
>> +     &meta_data_attr,
>> +     NULL,
>> +};
>> +
>> +static const struct attribute_group xrt_subdev_attrgroup = {
>> +     .attrs = xrt_subdev_attrs,
>> +     .bin_attrs = xrt_subdev_bin_attrs,
>> +};
>> +
>> +/*
>> + * Given the device metadata, parse it to get IO ranges and construct
>> + * resource array.
>> + */
>> +static int
>> +xrt_subdev_getres(struct device *parent, enum xrt_subdev_id id,
>> +               char *dtb, struct resource **res, int *res_num)
>> +{
>> +     struct xrt_subdev_platdata *pdata;
>> +     struct resource *pci_res = NULL;
>> +     const u64 *bar_range;
>> +     const u32 *bar_idx;
>> +     char *ep_name = NULL, *regmap = NULL;
>> +     uint bar;
>> +     int count1 = 0, count2 = 0, ret;
>> +
>> +     if (!dtb)
>> +             return -EINVAL;
>> +
>> +     pdata = DEV_PDATA(to_platform_device(parent));
>> +
>> +     /* go through metadata and count endpoints in it */
>> +     for (xrt_md_get_next_endpoint(parent, dtb, NULL, NULL, &ep_name, &regmap); ep_name;
> Embedding functions in the for-loop is difficult to debug consider change this loop into something easier to read.
>
> Maybe
>
> xrt_md_get_next_endpoint(parent, dtb, NULL, NULL, &ep_name, &regmap);
>
> while (ep_name) {
>
> ...
>
> xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap, &ep_name, &regmap)
>
> }
>
> similar below


Will change.


>> +          xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap, &ep_name, &regmap)) {
>> +             ret = xrt_md_get_prop(parent, dtb, ep_name, regmap,
>> +                                   XRT_MD_PROP_IO_OFFSET, (const void **)&bar_range, NULL);
>> +             if (!ret)
>> +                     count1++;
>> +     }
>> +     if (!count1)
>> +             return 0;
>> +
>> +     /* allocate resource array for all endpoints been found in metadata */
>> +     *res = vzalloc(sizeof(**res) * count1);
> if this is small, convert to kzalloc


It depends on the value of count1, so could be big. I'll keep it as is.


>> +
>> +     /* go through all endpoints again and get IO range for each endpoint */
>> +     for (xrt_md_get_next_endpoint(parent, dtb, NULL, NULL, &ep_name, &regmap); ep_name;
>> +          xrt_md_get_next_endpoint(parent, dtb, ep_name, regmap, &ep_name, &regmap)) {
>> +             ret = xrt_md_get_prop(parent, dtb, ep_name, regmap,
>> +                                   XRT_MD_PROP_IO_OFFSET, (const void **)&bar_range, NULL);
>> +             if (ret)
>> +                     continue;
>> +             xrt_md_get_prop(parent, dtb, ep_name, regmap,
>> +                             XRT_MD_PROP_BAR_IDX, (const void **)&bar_idx, NULL);
>> +             bar = bar_idx ? be32_to_cpu(*bar_idx) : 0;
>> +             xleaf_get_barres(to_platform_device(parent), &pci_res, bar);
>> +             (*res)[count2].start = pci_res->start +
>> +                     be64_to_cpu(bar_range[0]);
>> +             (*res)[count2].end = pci_res->start +
>> +                     be64_to_cpu(bar_range[0]) +
>> +                     be64_to_cpu(bar_range[1]) - 1;
>> +             (*res)[count2].flags = IORESOURCE_MEM;
>> +             /* check if there is conflicted resource */
>> +             ret = request_resource(pci_res, *res + count2);
>> +             if (ret) {
>> +                     dev_err(parent, "Conflict resource %pR\n", *res + count2);
>> +                     vfree(*res);
>> +                     *res_num = 0;
>> +                     *res = NULL;
>> +                     return ret;
>> +             }
>> +             release_resource(*res + count2);
>> +
>> +             (*res)[count2].parent = pci_res;
>> +
>> +             xrt_md_find_endpoint(parent, pdata->xsp_dtb, ep_name,
>> +                                  regmap, &(*res)[count2].name);
>> +
>> +             count2++;
>> +     }
>> +
>> +     WARN_ON(count1 != count2);
>> +     *res_num = count2;
>> +
>> +     return 0;
>> +}
>> +
>> +static inline enum xrt_subdev_file_mode
>> +xleaf_devnode_mode(struct xrt_subdev_drvdata *drvdata)
>> +{
>> +     return drvdata->xsd_file_ops.xsf_mode;
>> +}
>> +
>> +static bool xrt_subdev_cdev_auto_creation(struct platform_device *pdev)
>> +{
>> +     struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(pdev);
>> +     enum xrt_subdev_file_mode mode = xleaf_devnode_mode(drvdata);
>> +
>> +     if (!drvdata)
>> +             return false;
>> +
>> +     if (!xleaf_devnode_enabled(drvdata))
>> +             return false;
>> +
>> +     return (mode == XRT_SUBDEV_FILE_DEFAULT || mode == XRT_SUBDEV_FILE_MULTI_INST);
> should this check happen before xleaf_devnode_enable() ?


The code here has changed due to the bus type change. Please review the 
new code in next version.


>> +}
>> +
>> +static struct xrt_subdev *
>> +xrt_subdev_create(struct device *parent, enum xrt_subdev_id id,
>> +               xrt_subdev_root_cb_t pcb, void *pcb_arg, char *dtb)
>> +{
>> +     struct xrt_subdev_platdata *pdata = NULL;
>> +     struct platform_device *pdev = NULL;
>> +     int inst = PLATFORM_DEVID_NONE;
>> +     struct xrt_subdev *sdev = NULL;
>> +     struct resource *res = NULL;
>> +     unsigned long dtb_len = 0;
>> +     int res_num = 0;
>> +     size_t pdata_sz;
>> +     int ret;
>> +
>> +     sdev = xrt_subdev_alloc();
>> +     if (!sdev) {
>> +             dev_err(parent, "failed to alloc subdev for ID %d", id);
>> +             goto fail;
>> +     }
>> +     sdev->xs_id = id;
>> +
>> +     if (!dtb) {
>> +             ret = xrt_md_create(parent, &dtb);
>> +             if (ret) {
>> +                     dev_err(parent, "can't create empty dtb: %d", ret);
>> +                     goto fail;
>> +             }
>> +     }
>> +     xrt_md_pack(parent, dtb);
>> +     dtb_len = xrt_md_size(parent, dtb);
>> +     if (dtb_len == XRT_MD_INVALID_LENGTH) {
>> +             dev_err(parent, "invalid metadata len %ld", dtb_len);
>> +             goto fail;
>> +     }
>> +     pdata_sz = sizeof(struct xrt_subdev_platdata) + dtb_len;
> ok
>> +
>> +     /* Prepare platform data passed to subdev. */
>> +     pdata = vzalloc(pdata_sz);
>> +     if (!pdata)
>> +             goto fail;
>> +
>> +     pdata->xsp_root_cb = pcb;
>> +     pdata->xsp_root_cb_arg = pcb_arg;
>> +     memcpy(pdata->xsp_dtb, dtb, dtb_len);
>> +     if (id == XRT_SUBDEV_GRP) {
>> +             /* Group can only be created by root driver. */
>> +             pdata->xsp_root_name = dev_name(parent);
>> +     } else {
>> +             struct platform_device *grp = to_platform_device(parent);
>> +             /* Leaf can only be created by group driver. */
>> +             WARN_ON(strncmp(xrt_drv_name(XRT_SUBDEV_GRP),
>> +                             platform_get_device_id(grp)->name,
>> +                             strlen(xrt_drv_name(XRT_SUBDEV_GRP)) + 1));
>> +             pdata->xsp_root_name = DEV_PDATA(grp)->xsp_root_name;
>> +     }
>> +
>> +     /* Obtain dev instance number. */
>> +     inst = xrt_drv_get_instance(id);
>> +     if (inst < 0) {
>> +             dev_err(parent, "failed to obtain instance: %d", inst);
>> +             goto fail;
>> +     }
>> +
>> +     /* Create subdev. */
>> +     if (id != XRT_SUBDEV_GRP) {
>> +             int rc = xrt_subdev_getres(parent, id, dtb, &res, &res_num);
>> +
>> +             if (rc) {
>> +                     dev_err(parent, "failed to get resource for %s.%d: %d",
>> +                             xrt_drv_name(id), inst, rc);
>> +                     goto fail;
>> +             }
>> +     }
>> +     pdev = platform_device_register_resndata(parent, xrt_drv_name(id),
>> +                                              inst, res, res_num, pdata, pdata_sz);
> ok
>> +     vfree(res);
>> +     if (IS_ERR(pdev)) {
>> +             dev_err(parent, "failed to create subdev for %s inst %d: %ld",
>> +                     xrt_drv_name(id), inst, PTR_ERR(pdev));
>> +             goto fail;
>> +     }
>> +     sdev->xs_pdev = pdev;
>> +
>> +     if (device_attach(DEV(pdev)) != 1) {
>> +             xrt_err(pdev, "failed to attach");
>> +             goto fail;
>> +     }
>> +
>> +     if (sysfs_create_group(&DEV(pdev)->kobj, &xrt_subdev_attrgroup))
>> +             xrt_err(pdev, "failed to create sysfs group");
>> +
>> +     /*
>> +      * Create sysfs sym link under root for leaves
>> +      * under random groups for easy access to them.
>> +      */
>> +     if (id != XRT_SUBDEV_GRP) {
>> +             if (sysfs_create_link(&find_root(pdev)->kobj,
>> +                                   &DEV(pdev)->kobj, dev_name(DEV(pdev)))) {
>> +                     xrt_err(pdev, "failed to create sysfs link");
>> +             }
>> +     }
>> +
>> +     /* All done, ready to handle req thru cdev. */
>> +     if (xrt_subdev_cdev_auto_creation(pdev))
>> +             xleaf_devnode_create(pdev, DEV_DRVDATA(pdev)->xsd_file_ops.xsf_dev_name, NULL);
>> +
>> +     vfree(pdata);
>> +     return sdev;
>> +
>> +fail:
> Take another look at splitting this error handling.
>
> Jumping to specific labels is more common.


Will change.


>> +     vfree(pdata);
>> +     if (sdev && !IS_ERR_OR_NULL(sdev->xs_pdev))
>> +             platform_device_unregister(sdev->xs_pdev);
>> +     if (inst >= 0)
>> +             xrt_drv_put_instance(id, inst);
>> +     xrt_subdev_free(sdev);
>> +     return NULL;
>> +}
>> +
>> +static void xrt_subdev_destroy(struct xrt_subdev *sdev)
>> +{
>> +     struct platform_device *pdev = sdev->xs_pdev;
>> +     struct device *dev = DEV(pdev);
>> +     int inst = pdev->id;
>> +     int ret;
>> +
>> +     /* Take down the device node */
>> +     if (xrt_subdev_cdev_auto_creation(pdev)) {
>> +             ret = xleaf_devnode_destroy(pdev);
>> +             WARN_ON(ret);
>> +     }
>> +     if (sdev->xs_id != XRT_SUBDEV_GRP)
>> +             sysfs_remove_link(&find_root(pdev)->kobj, dev_name(dev));
>> +     sysfs_remove_group(&dev->kobj, &xrt_subdev_attrgroup);
>> +     platform_device_unregister(pdev);
>> +     xrt_drv_put_instance(sdev->xs_id, inst);
>> +     xrt_subdev_free(sdev);
>> +}
>> +
>> +struct platform_device *
>> +xleaf_get_leaf(struct platform_device *pdev, xrt_subdev_match_t match_cb, void *match_arg)
>> +{
>> +     int rc;
>> +     struct xrt_root_get_leaf get_leaf = {
>> +             pdev, match_cb, match_arg, };
>> +
>> +     rc = xrt_subdev_root_request(pdev, XRT_ROOT_GET_LEAF, &get_leaf);
>> +     if (rc)
>> +             return NULL;
>> +     return get_leaf.xpigl_tgt_pdev;
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_get_leaf);
>> +
>> +bool xleaf_has_endpoint(struct platform_device *pdev, const char *endpoint_name)
>> +{
>> +     struct resource *res;
>> +     int i = 0;
> ok
>> +
>> +     do {
>> +             res = platform_get_resource(pdev, IORESOURCE_MEM, i);
>> +             if (res && !strncmp(res->name, endpoint_name, strlen(res->name) + 1))
>> +                     return true;
>> +             ++i;
> ok
>> +     } while (res);
>> +
>> +     return false;
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_has_endpoint);
>> +
>> +int xleaf_put_leaf(struct platform_device *pdev, struct platform_device *leaf)
>> +{
>> +     struct xrt_root_put_leaf put_leaf = { pdev, leaf };
>> +
>> +     return xrt_subdev_root_request(pdev, XRT_ROOT_PUT_LEAF, &put_leaf);
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_put_leaf);
>> +
>> +int xleaf_create_group(struct platform_device *pdev, char *dtb)
>> +{
>> +     return xrt_subdev_root_request(pdev, XRT_ROOT_CREATE_GROUP, dtb);
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_create_group);
>> +
>> +int xleaf_destroy_group(struct platform_device *pdev, int instance)
>> +{
>> +     return xrt_subdev_root_request(pdev, XRT_ROOT_REMOVE_GROUP, (void *)(uintptr_t)instance);
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_destroy_group);
>> +
>> +int xleaf_wait_for_group_bringup(struct platform_device *pdev)
>> +{
>> +     return xrt_subdev_root_request(pdev, XRT_ROOT_WAIT_GROUP_BRINGUP, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_wait_for_group_bringup);
>> +
>> +static ssize_t
>> +xrt_subdev_get_holders(struct xrt_subdev *sdev, char *buf, size_t len)
>> +{
>> +     const struct list_head *ptr;
>> +     struct xrt_subdev_holder *h;
>> +     ssize_t n = 0;
>> +
>> +     list_for_each(ptr, &sdev->xs_holder_list) {
>> +             h = list_entry(ptr, struct xrt_subdev_holder, xsh_holder_list);
>> +             n += snprintf(buf + n, len - n, "%s:%d ",
>> +                           dev_name(h->xsh_holder), kref_read(&h->xsh_kref));
> add a comment that truncation is fine


Will change.


>> +             if (n >= (len - 1))
>> +                     break;
>> +     }
>> +     return n;
>> +}
>> +
>> +void xrt_subdev_pool_init(struct device *dev, struct xrt_subdev_pool *spool)
>> +{
>> +     INIT_LIST_HEAD(&spool->xsp_dev_list);
>> +     spool->xsp_owner = dev;
>> +     mutex_init(&spool->xsp_lock);
>> +     spool->xsp_closing = false;
>> +}
>> +
>> +static void xrt_subdev_free_holder(struct xrt_subdev_holder *holder)
>> +{
>> +     list_del(&holder->xsh_holder_list);
>> +     vfree(holder);
>> +}
>> +
>> +static void xrt_subdev_pool_wait_for_holders(struct xrt_subdev_pool *spool, struct xrt_subdev *sdev)
>> +{
>> +     const struct list_head *ptr, *next;
>> +     char holders[128];
>> +     struct xrt_subdev_holder *holder;
>> +     struct mutex *lk = &spool->xsp_lock;
>> +
>> +     while (!list_empty(&sdev->xs_holder_list)) {
>> +             int rc;
>> +
>> +             /* It's most likely a bug if we ever enters this loop. */
>> +             xrt_subdev_get_holders(sdev, holders, sizeof(holders));
> Items just for debugging need to run just for debugging


Please see my comment at the beginning of this reply. I'd like to keep 
the error msg here. This error msg might be very valuable to us since it 
might help to debug a race condition which is not easy to reproduce.

Thanks,

Max


>> +             xrt_err(sdev->xs_pdev, "awaits holders: %s", holders);
>> +             mutex_unlock(lk);
>> +             rc = wait_for_completion_killable(&sdev->xs_holder_comp);
>> +             mutex_lock(lk);
>> +             if (rc == -ERESTARTSYS) {
>> +                     xrt_err(sdev->xs_pdev, "give up on waiting for holders, clean up now");
>> +                     list_for_each_safe(ptr, next, &sdev->xs_holder_list) {
>> +                             holder = list_entry(ptr, struct xrt_subdev_holder, xsh_holder_list);
>> +                             xrt_subdev_free_holder(holder);
>> +                     }
>> +             }
>> +     }
>> +}
>> +
>> +void xrt_subdev_pool_fini(struct xrt_subdev_pool *spool)
>> +{
>> +     struct list_head *dl = &spool->xsp_dev_list;
>> +     struct mutex *lk = &spool->xsp_lock;
>> +
>> +     mutex_lock(lk);
>> +     if (spool->xsp_closing) {
>> +             mutex_unlock(lk);
>> +             return;
>> +     }
>> +     spool->xsp_closing = true;
>> +     mutex_unlock(lk);
> ok
>> +
>> +     /* Remove subdev in the reverse order of added. */
>> +     while (!list_empty(dl)) {
>> +             struct xrt_subdev *sdev = list_first_entry(dl, struct xrt_subdev, xs_dev_list);
>> +
>> +             xrt_subdev_pool_wait_for_holders(spool, sdev);
>> +             list_del(&sdev->xs_dev_list);
>> +             xrt_subdev_destroy(sdev);
>> +     }
>> +}
>> +
>> +static struct xrt_subdev_holder *xrt_subdev_find_holder(struct xrt_subdev *sdev,
>> +                                                     struct device *holder_dev)
>> +{
>> +     struct list_head *hl = &sdev->xs_holder_list;
>> +     struct xrt_subdev_holder *holder;
>> +     const struct list_head *ptr;
>> +
>> +     list_for_each(ptr, hl) {
>> +             holder = list_entry(ptr, struct xrt_subdev_holder, xsh_holder_list);
>> +             if (holder->xsh_holder == holder_dev)
>> +                     return holder;
>> +     }
>> +     return NULL;
>> +}
>> +
>> +static int xrt_subdev_hold(struct xrt_subdev *sdev, struct device *holder_dev)
>> +{
>> +     struct xrt_subdev_holder *holder = xrt_subdev_find_holder(sdev, holder_dev);
>> +     struct list_head *hl = &sdev->xs_holder_list;
>> +
>> +     if (!holder) {
>> +             holder = vzalloc(sizeof(*holder));
>> +             if (!holder)
>> +                     return -ENOMEM;
>> +             holder->xsh_holder = holder_dev;
>> +             kref_init(&holder->xsh_kref);
>> +             list_add_tail(&holder->xsh_holder_list, hl);
>> +     } else {
>> +             kref_get(&holder->xsh_kref);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static void xrt_subdev_free_holder_kref(struct kref *kref)
>> +{
>> +     struct xrt_subdev_holder *holder = container_of(kref, struct xrt_subdev_holder, xsh_kref);
>> +
>> +     xrt_subdev_free_holder(holder);
>> +}
>> +
>> +static int
>> +xrt_subdev_release(struct xrt_subdev *sdev, struct device *holder_dev)
>> +{
>> +     struct xrt_subdev_holder *holder = xrt_subdev_find_holder(sdev, holder_dev);
>> +     struct list_head *hl = &sdev->xs_holder_list;
>> +
>> +     if (!holder) {
>> +             dev_err(holder_dev, "can't release, %s did not hold %s",
>> +                     dev_name(holder_dev), dev_name(DEV(sdev->xs_pdev)));
>> +             return -EINVAL;
>> +     }
>> +     kref_put(&holder->xsh_kref, xrt_subdev_free_holder_kref);
>> +
>> +     /* kref_put above may remove holder from list. */
>> +     if (list_empty(hl))
>> +             complete(&sdev->xs_holder_comp);
>> +     return 0;
>> +}
>> +
>> +int xrt_subdev_pool_add(struct xrt_subdev_pool *spool, enum xrt_subdev_id id,
>> +                     xrt_subdev_root_cb_t pcb, void *pcb_arg, char *dtb)
>> +{
>> +     struct mutex *lk = &spool->xsp_lock;
>> +     struct list_head *dl = &spool->xsp_dev_list;
>> +     struct xrt_subdev *sdev;
>> +     int ret = 0;
>> +
>> +     sdev = xrt_subdev_create(spool->xsp_owner, id, pcb, pcb_arg, dtb);
>> +     if (sdev) {
>> +             mutex_lock(lk);
>> +             if (spool->xsp_closing) {
>> +                     /* No new subdev when pool is going away. */
>> +                     xrt_err(sdev->xs_pdev, "pool is closing");
>> +                     ret = -ENODEV;
>> +             } else {
>> +                     list_add(&sdev->xs_dev_list, dl);
>> +             }
>> +             mutex_unlock(lk);
>> +             if (ret)
>> +                     xrt_subdev_destroy(sdev);
>> +     } else {
>> +             ret = -EINVAL;
>> +     }
>> +
>> +     ret = ret ? ret : sdev->xs_pdev->id;
>> +     return ret;
>> +}
>> +
>> +int xrt_subdev_pool_del(struct xrt_subdev_pool *spool, enum xrt_subdev_id id, int instance)
>> +{
>> +     const struct list_head *ptr;
>> +     struct mutex *lk = &spool->xsp_lock;
>> +     struct list_head *dl = &spool->xsp_dev_list;
>> +     struct xrt_subdev *sdev;
>> +     int ret = -ENOENT;
>> +
>> +     mutex_lock(lk);
>> +     if (spool->xsp_closing) {
>> +             /* Pool is going away, all subdevs will be gone. */
>> +             mutex_unlock(lk);
>> +             return 0;
>> +     }
>> +     list_for_each(ptr, dl) {
>> +             sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
>> +             if (sdev->xs_id != id || sdev->xs_pdev->id != instance)
>> +                     continue;
>> +             xrt_subdev_pool_wait_for_holders(spool, sdev);
>> +             list_del(&sdev->xs_dev_list);
>> +             ret = 0;
>> +             break;
>> +     }
>> +     mutex_unlock(lk);
>> +     if (ret)
>> +             return ret;
>> +
>> +     xrt_subdev_destroy(sdev);
>> +     return 0;
>> +}
>> +
>> +static int xrt_subdev_pool_get_impl(struct xrt_subdev_pool *spool, xrt_subdev_match_t match,
>> +                                 void *arg, struct device *holder_dev, struct xrt_subdev **sdevp)
>> +{
>> +     struct platform_device *pdev = (struct platform_device *)arg;
>> +     struct list_head *dl = &spool->xsp_dev_list;
>> +     struct mutex *lk = &spool->xsp_lock;
>> +     struct xrt_subdev *sdev = NULL;
>> +     const struct list_head *ptr;
>> +     struct xrt_subdev *d = NULL;
>> +     int ret = -ENOENT;
>> +
>> +     mutex_lock(lk);
>> +
>> +     if (!pdev) {
>> +             if (match == XRT_SUBDEV_MATCH_PREV) {
>> +                     sdev = list_empty(dl) ? NULL :
>> +                             list_last_entry(dl, struct xrt_subdev, xs_dev_list);
>> +             } else if (match == XRT_SUBDEV_MATCH_NEXT) {
>> +                     sdev = list_first_entry_or_null(dl, struct xrt_subdev, xs_dev_list);
>> +             }
>> +     }
>> +
>> +     list_for_each(ptr, dl) {
> ok
>> +             d = list_entry(ptr, struct xrt_subdev, xs_dev_list);
>> +             if (match == XRT_SUBDEV_MATCH_PREV || match == XRT_SUBDEV_MATCH_NEXT) {
>> +                     if (d->xs_pdev != pdev)
>> +                             continue;
>> +             } else {
>> +                     if (!match(d->xs_id, d->xs_pdev, arg))
>> +                             continue;
>> +             }
>> +
>> +             if (match == XRT_SUBDEV_MATCH_PREV)
>> +                     sdev = !list_is_first(ptr, dl) ? list_prev_entry(d, xs_dev_list) : NULL;
>> +             else if (match == XRT_SUBDEV_MATCH_NEXT)
>> +                     sdev = !list_is_last(ptr, dl) ? list_next_entry(d, xs_dev_list) : NULL;
>> +             else
>> +                     sdev = d;
>> +     }
>> +
>> +     if (sdev)
>> +             ret = xrt_subdev_hold(sdev, holder_dev);
>> +
>> +     mutex_unlock(lk);
>> +
>> +     if (!ret)
>> +             *sdevp = sdev;
>> +     return ret;
>> +}
>> +
>> +int xrt_subdev_pool_get(struct xrt_subdev_pool *spool, xrt_subdev_match_t match, void *arg,
>> +                     struct device *holder_dev, struct platform_device **pdevp)
>> +{
>> +     int rc;
>> +     struct xrt_subdev *sdev;
>> +
>> +     rc = xrt_subdev_pool_get_impl(spool, match, arg, holder_dev, &sdev);
>> +     if (rc) {
>> +             if (rc != -ENOENT)
>> +                     dev_err(holder_dev, "failed to hold device: %d", rc);
>> +             return rc;
>> +     }
>> +
>> +     if (!IS_ROOT_DEV(holder_dev)) {
> ok
>> +             xrt_dbg(to_platform_device(holder_dev), "%s <<==== %s",
>> +                     dev_name(holder_dev), dev_name(DEV(sdev->xs_pdev)));
>> +     }
>> +
>> +     *pdevp = sdev->xs_pdev;
>> +     return 0;
>> +}
>> +
>> +static int xrt_subdev_pool_put_impl(struct xrt_subdev_pool *spool, struct platform_device *pdev,
>> +                                 struct device *holder_dev)
>> +{
>> +     const struct list_head *ptr;
>> +     struct mutex *lk = &spool->xsp_lock;
>> +     struct list_head *dl = &spool->xsp_dev_list;
>> +     struct xrt_subdev *sdev;
>> +     int ret = -ENOENT;
>> +
>> +     mutex_lock(lk);
>> +     list_for_each(ptr, dl) {
>> +             sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
>> +             if (sdev->xs_pdev != pdev)
>> +                     continue;
>> +             ret = xrt_subdev_release(sdev, holder_dev);
>> +             break;
>> +     }
>> +     mutex_unlock(lk);
>> +
>> +     return ret;
>> +}
>> +
>> +int xrt_subdev_pool_put(struct xrt_subdev_pool *spool, struct platform_device *pdev,
>> +                     struct device *holder_dev)
>> +{
>> +     int ret = xrt_subdev_pool_put_impl(spool, pdev, holder_dev);
>> +
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (!IS_ROOT_DEV(holder_dev)) {
> ok
>> +             xrt_dbg(to_platform_device(holder_dev), "%s <<==X== %s",
>> +                     dev_name(holder_dev), dev_name(DEV(pdev)));
>> +     }
>> +     return 0;
>> +}
>> +
>> +void xrt_subdev_pool_trigger_event(struct xrt_subdev_pool *spool, enum xrt_events e)
>> +{
>> +     struct platform_device *tgt = NULL;
>> +     struct xrt_subdev *sdev = NULL;
>> +     struct xrt_event evt;
>> +
>> +     while (!xrt_subdev_pool_get_impl(spool, XRT_SUBDEV_MATCH_NEXT,
>> +                                      tgt, spool->xsp_owner, &sdev)) {
>> +             tgt = sdev->xs_pdev;
>> +             evt.xe_evt = e;
>> +             evt.xe_subdev.xevt_subdev_id = sdev->xs_id;
>> +             evt.xe_subdev.xevt_subdev_instance = tgt->id;
>> +             xrt_subdev_root_request(tgt, XRT_ROOT_EVENT_SYNC, &evt);
>> +             xrt_subdev_pool_put_impl(spool, tgt, spool->xsp_owner);
>> +     }
>> +}
>> +
>> +void xrt_subdev_pool_handle_event(struct xrt_subdev_pool *spool, struct xrt_event *evt)
>> +{
>> +     struct platform_device *tgt = NULL;
>> +     struct xrt_subdev *sdev = NULL;
>> +
>> +     while (!xrt_subdev_pool_get_impl(spool, XRT_SUBDEV_MATCH_NEXT,
>> +                                      tgt, spool->xsp_owner, &sdev)) {
>> +             tgt = sdev->xs_pdev;
>> +             xleaf_call(tgt, XRT_XLEAF_EVENT, evt);
>> +             xrt_subdev_pool_put_impl(spool, tgt, spool->xsp_owner);
>> +     }
>> +}
>> +
>> +ssize_t xrt_subdev_pool_get_holders(struct xrt_subdev_pool *spool,
>> +                                 struct platform_device *pdev, char *buf, size_t len)
>> +{
>> +     const struct list_head *ptr;
>> +     struct mutex *lk = &spool->xsp_lock;
>> +     struct list_head *dl = &spool->xsp_dev_list;
>> +     struct xrt_subdev *sdev;
>> +     ssize_t ret = 0;
>> +
>> +     mutex_lock(lk);
>> +     list_for_each(ptr, dl) {
>> +             sdev = list_entry(ptr, struct xrt_subdev, xs_dev_list);
>> +             if (sdev->xs_pdev != pdev)
>> +                     continue;
>> +             ret = xrt_subdev_get_holders(sdev, buf, len);
>> +             break;
>> +     }
>> +     mutex_unlock(lk);
>> +
>> +     return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(xrt_subdev_pool_get_holders);
>> +
>> +int xleaf_broadcast_event(struct platform_device *pdev, enum xrt_events evt, bool async)
>> +{
>> +     struct xrt_event e = { evt, };
>> +     enum xrt_root_cmd cmd = async ? XRT_ROOT_EVENT_ASYNC : XRT_ROOT_EVENT_SYNC;
>> +
>> +     WARN_ON(evt == XRT_EVENT_POST_CREATION || evt == XRT_EVENT_PRE_REMOVAL);
>> +     return xrt_subdev_root_request(pdev, cmd, &e);
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_broadcast_event);
>> +
>> +void xleaf_hot_reset(struct platform_device *pdev)
>> +{
>> +     xrt_subdev_root_request(pdev, XRT_ROOT_HOT_RESET, NULL);
>> +}
>> +EXPORT_SYMBOL_GPL(xleaf_hot_reset);
>> +
>> +void xleaf_get_barres(struct platform_device *pdev, struct resource **res, uint bar_idx)
>> +{
>> +     struct xrt_root_get_res arg = { 0 };
>> +
>> +     if (bar_idx > PCI_STD_RESOURCE_END) {
>> +             xrt_err(pdev, "Invalid bar idx %d", bar_idx);
>> +             *res = NULL;
>> +             return;
>> +     }
>> +
>> +     xrt_subdev_root_request(pdev, XRT_ROOT_GET_RESOURCE, &arg);
>> +
>> +     *res = &arg.xpigr_res[bar_idx];
>> +}
>> +
>> +void xleaf_get_root_id(struct platform_device *pdev, unsigned short *vendor, unsigned short *device,
>> +                    unsigned short *subvendor, unsigned short *subdevice)
>> +{
>> +     struct xrt_root_get_id id = { 0 };
>> +
>> +     WARN_ON(!vendor && !device && !subvendor && !subdevice);
> ok
>
> Tom
>
>> +
>> +     xrt_subdev_root_request(pdev, XRT_ROOT_GET_ID, (void *)&id);
>> +     if (vendor)
>> +             *vendor = id.xpigi_vendor_id;
>> +     if (device)
>> +             *device = id.xpigi_device_id;
>> +     if (subvendor)
>> +             *subvendor = id.xpigi_sub_vendor_id;
>> +     if (subdevice)
>> +             *subdevice = id.xpigi_sub_device_id;
>> +}
>> +
>> +struct device *xleaf_register_hwmon(struct platform_device *pdev, const char *name, void *drvdata,
>> +                                 const struct attribute_group **grps)
>> +{
>> +     struct xrt_root_hwmon hm = { true, name, drvdata, grps, };
>> +
>> +     xrt_subdev_root_request(pdev, XRT_ROOT_HWMON, (void *)&hm);
>> +     return hm.xpih_hwmon_dev;
>> +}
>> +
>> +void xleaf_unregister_hwmon(struct platform_device *pdev, struct device *hwmon)
>> +{
>> +     struct xrt_root_hwmon hm = { false, };
>> +
>> +     hm.xpih_hwmon_dev = hwmon;
>> +     xrt_subdev_root_request(pdev, XRT_ROOT_HWMON, (void *)&hm);
>> +}
