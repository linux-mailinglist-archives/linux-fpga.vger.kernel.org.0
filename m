Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500F033E270
	for <lists+linux-fpga@lfdr.de>; Wed, 17 Mar 2021 00:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbhCPXzM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 16 Mar 2021 19:55:12 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:49946
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229802AbhCPXzA (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 16 Mar 2021 19:55:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFpzaJvbYmmltbx3p4RP4X11kuZrl1JaajibRnViS1e0ZzlahaoBBNF248YQQGeW/NnXeAbwWLV9jYpBGpFHJynzpe2E5NVNdg3lgRUUswCJULCLvjmc8jS8waPf4T8KuiIn6KriNomPfFeUnj8PMvTVVgAmtXzx8A/Tg89MDbefDknNpiHT+HIFI/4UjivWZFBHacQgMB+n5tevvakji0NZ3QLY/Wgdh2cQeK850tIarogDsEq4Gyy546sTZNqrKbuZV11SpE/cQVbB2ScdvHoJMrkE9W/SA46LJBmHnO7nCqJm3S3kJQKW45p35+7KbXPhS1Ar/637p2Sv3JRnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zHT3HYXHlWzGB3wDPm8v+bYp6EUuEuIX3ac8w5JTjc=;
 b=UuUJduFR0R1q26oZpJdqI6AECIWnChh6fKWSnPs/jS/pal92v5ya/NvypR7x6NcZ4J6nLWgLpkKLBWiSlPIB8ujAK5J38ZzP3wYD9E0b1hY9dpcjJt+5vQApcd1KRMTVTLoT9Ub0eM7Ae2gs6r+cpysZdTDjKjoRzJ2n9iLrWHO++pUociVJgYhSgFadqAGgZuIYPB7BTl8LGAHLnDKEinPhmqlzUpyzlBlNN5LpoYT88vWJ3qcvNEGuiJH69Sfi7yBRtMp0suvQ/rW7HpKSaBz8En7irT1KBMyIoKqefCUAYMpuRTqqhJgHh5sd3Zi3sUyvSoWLhQab8P01EnthFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zHT3HYXHlWzGB3wDPm8v+bYp6EUuEuIX3ac8w5JTjc=;
 b=UHFdJg9uBKinfArHAtlD0lhkwuXLKqb/0DniJOh5BFicoDRGHzZeH75s7YdhCg2tioxEuV56qz7+VKaZHp86jp/Y21kavERAd9qIDb1W66svHIzh0niRLFpVsdH0mAJRveL99pqxuv1U1i/07hivWP50n6LeRRHlEGCLsBsKEtQ=
Received: from CY4PR2201CA0003.namprd22.prod.outlook.com
 (2603:10b6:910:5f::13) by BL0PR02MB6547.namprd02.prod.outlook.com
 (2603:10b6:208:1c8::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 23:54:57 +0000
Received: from CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
 (2603:10b6:910:5f:cafe::e) by CY4PR2201CA0003.outlook.office365.com
 (2603:10b6:910:5f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32 via Frontend
 Transport; Tue, 16 Mar 2021 23:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT013.mail.protection.outlook.com (10.152.75.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.32 via Frontend Transport; Tue, 16 Mar 2021 23:54:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 16 Mar 2021 16:54:57 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 16 Mar 2021 16:54:57 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=54544)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lMJWb-00004s-7d; Tue, 16 Mar 2021 16:54:57 -0700
Subject: Re: [PATCH V3 XRT Alveo 13/18] fpga: xrt: devctl platform driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-14-lizhih@xilinx.com>
 <f32d06bc-1054-eb97-cce1-9b40e9c4442b@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <20b2a60e-1ed1-c466-ce0b-26179338390e@xilinx.com>
Date:   Tue, 16 Mar 2021 16:54:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <f32d06bc-1054-eb97-cce1-9b40e9c4442b@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47590b26-a0e3-4177-a2b4-08d8e8d6e75f
X-MS-TrafficTypeDiagnostic: BL0PR02MB6547:
X-Microsoft-Antispam-PRVS: <BL0PR02MB6547996935BC9E89B2F6A071A16B9@BL0PR02MB6547.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8IScRck1Cn2H2OssrN9hODeLds5Bq9R2ENVH+p1xP6xTLKWmGQEun47TG9F01aExXGVjqDvusx+Z7GDnWZvMyQFwNS5iTASsg/aUxjH68M85Xo/392T1RMdPDUou4xVAnInfPDBm6d+5QZzSyeyMuQbJ23+BHAQiaWZpqLG94XGFd9bIGwEyJqDFFVyIZYIhGgNvY9nf52REfy1shB4ZQPjnQunj3NZpjYAFXC2aDja06Zp4uHNOu6kohSs3+p7NHR1f89uBNj1J6Jtjj59TREbrzal+3yfX5LXy5WWWvPbA3bZ5NZSWqVMDFhROqrZgw3LMWLRTbb1QEnEo4RQRBB0Fo8vCoCwI+5fyvnHJ9mC8w8wu3pvtOUjB0L7D2jcV9NXxb70ERqFU4kX6O4VmmqSo/ulttPZEFhIPK/2HxOzPoxKJugEsl2U1Jto/p+WMOES5IvevKAymO0bvZCuMMhmxvpIYzUB2L6srL64QhWKvjrmxktBMkYO96wktoGgET9MxSz5uKLcsMy2+u+CkJFtKiVf6dMYgoozpDhsyA2qvh7WsnloOj8ZXSgBHBJx3SuQjQJgy+CsyiB4sLHjViyjYTn0sDtfp0/pSqcan1sbe1MLptUgyElI9KJRSOr4jEJs1eKGwDJs48NbU8GliIvX6Tqybkh3FwZ75BRbGA0Q1t7DgSGZmL85VfbqM4oTbb0JFD/vXsNpur77kCFhIOKpXmeZvYWU/bfQ0LfpdNCU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39850400004)(376002)(396003)(46966006)(36840700001)(8936002)(4326008)(316002)(31696002)(107886003)(110136005)(26005)(9786002)(36906005)(53546011)(336012)(70206006)(186003)(31686004)(2616005)(8676002)(2906002)(54906003)(478600001)(7636003)(83380400001)(356005)(36756003)(82740400003)(36860700001)(82310400003)(47076005)(44832011)(70586007)(426003)(5660300002)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 23:54:57.4735
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47590b26-a0e3-4177-a2b4-08d8e8d6e75f
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT013.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6547
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 03/04/2021 05:39 AM, Tom Rix wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> Add devctl driver. devctl is a type of hardware function which only has
>> few registers to read or write. They are discovered by walking firmware
>> metadata. A platform device node will be created for them.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/xleaf/devctl.h |  43 +++++
>>   drivers/fpga/xrt/lib/xleaf/devctl.c     | 206 ++++++++++++++++++++++++
>>   2 files changed, 249 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>>
>> diff --git a/drivers/fpga/xrt/include/xleaf/devctl.h b/drivers/fpga/xrt/include/xleaf/devctl.h
>> new file mode 100644
>> index 000000000000..96a40e066f83
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/xleaf/devctl.h
>> @@ -0,0 +1,43 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for XRT DEVCTL Leaf Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Lizhi Hou <Lizhi.Hou@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_DEVCTL_H_
>> +#define _XRT_DEVCTL_H_
>> +
>> +#include "xleaf.h"
>> +
>> +/*
>> + * DEVCTL driver IOCTL calls.
>> + */
>> +enum xrt_devctl_ioctl_cmd {
>> +     XRT_DEVCTL_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
>> +     XRT_DEVCTL_WRITE,
>> +};
>> +
>> +enum xrt_devctl_id {
>> +     XRT_DEVCTL_ROM_UUID,
> Assumes 0, should make this explicit and initialize to 0
Sure.
>> +     XRT_DEVCTL_DDR_CALIB,
>> +     XRT_DEVCTL_GOLDEN_VER,
>> +     XRT_DEVCTL_MAX
>> +};
>> +
>> +struct xrt_devctl_ioctl_rw {
>> +     u32     xgir_id;
>> +     void    *xgir_buf;
>> +     u32     xgir_len;
>> +     u32     xgir_offset;
> similar to other patches, the xgir_ prefix is not needed
>> +};
>> +
>> +struct xrt_devctl_ioctl_intf_uuid {
>> +     u32     xgir_uuid_num;
>> +     uuid_t  *xgir_uuids;
>> +};
>> +
>> +#endif       /* _XRT_DEVCTL_H_ */
>> diff --git a/drivers/fpga/xrt/lib/xleaf/devctl.c b/drivers/fpga/xrt/lib/xleaf/devctl.c
>> new file mode 100644
>> index 000000000000..caf8c6569f0f
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/xleaf/devctl.c
>> @@ -0,0 +1,206 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo FPGA devctl Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
>> + */
>> +
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include "metadata.h"
>> +#include "xleaf.h"
>> +#include "xleaf/devctl.h"
>> +
>> +#define XRT_DEVCTL "xrt_devctl"
>> +
>> +struct xrt_name_id {
>> +     char *ep_name;
>> +     int id;
>> +};
>> +
>> +static struct xrt_name_id name_id[XRT_DEVCTL_MAX] = {
>> +     { XRT_MD_NODE_BLP_ROM, XRT_DEVCTL_ROM_UUID },
>> +     { XRT_MD_NODE_GOLDEN_VER, XRT_DEVCTL_GOLDEN_VER },
> DDR_CALIB is unused ?
Not sure if I understand the question correctly. ddr_calib will have 
more things need to handle other than just read/write.
>> +};
>> +
>> +struct xrt_devctl {
>> +     struct platform_device  *pdev;
>> +     void            __iomem *base_addrs[XRT_DEVCTL_MAX];
>> +     ulong                   sizes[XRT_DEVCTL_MAX];
>> +};
> similar to other patches, why not use regmap ?
Will change to regmap.
>> +
>> +static int xrt_devctl_name2id(struct xrt_devctl *devctl, const char *name)
>> +{
>> +     int     i;
>> +
>> +     for (i = 0; i < XRT_DEVCTL_MAX && name_id[i].ep_name; i++) {
>> +             if (!strncmp(name_id[i].ep_name, name, strlen(name_id[i].ep_name) + 1))
>> +                     return name_id[i].id;
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static int
>> +xrt_devctl_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
>> +{
>> +     struct xrt_devctl       *devctl;
>> +     int                     ret = 0;
>> +
>> +     devctl = platform_get_drvdata(pdev);
>> +
>> +     switch (cmd) {
>> +     case XRT_XLEAF_EVENT:
>> +             /* Does not handle any event. */
>> +             break;
>> +     case XRT_DEVCTL_READ: {
>> +             struct xrt_devctl_ioctl_rw      *rw_arg = arg;
>> +             u32                             *p_src, *p_dst, i;
>> +
>> +             if (rw_arg->xgir_len & 0x3) {
>> +                     xrt_err(pdev, "invalid len %d", rw_arg->xgir_len);
>> +                     return -EINVAL;
>> +             }
>> +
>> +             if (rw_arg->xgir_id >= XRT_DEVCTL_MAX) {
>> +                     xrt_err(pdev, "invalid id %d", rw_arg->xgir_id);
>> +                     return -EINVAL;
>> +             }
> needs a < 0 check ?
change xgir_id to u32.
>> +
>> +             p_src = devctl->base_addrs[rw_arg->xgir_id];
>> +             if (!p_src) {
>> +                     xrt_err(pdev, "io not found, id %d",
>> +                             rw_arg->xgir_id);
>> +                     return -EINVAL;
>> +             }
>> +             if (rw_arg->xgir_offset + rw_arg->xgir_len >
>> +                 devctl->sizes[rw_arg->xgir_id]) {
>> +                     xrt_err(pdev, "invalid argument, off %d, len %d",
>> +                             rw_arg->xgir_offset, rw_arg->xgir_len);
>> +                     return -EINVAL;
>> +             }
>> +             p_dst = rw_arg->xgir_buf;
>> +             for (i = 0; i < rw_arg->xgir_len / sizeof(u32); i++) {
>> +                     u32 val = ioread32(p_src + rw_arg->xgir_offset + i);
>> +
>> +                     memcpy(p_dst + i, &val, sizeof(u32));
>> +             }
>> +             break;
>> +     }
> The _WRITE msg is not handled Then why have it ?
Will remove write msg from this patch set and add it back in future patches.

Thanks,
Lizhi
>
> Tom
>
>> +     default:
>> +             xrt_err(pdev, "unsupported cmd %d", cmd);
>> +             return -EINVAL;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int xrt_devctl_remove(struct platform_device *pdev)
>> +{
>> +     struct xrt_devctl       *devctl;
>> +     int                     i;
>> +
>> +     devctl = platform_get_drvdata(pdev);
>> +
>> +     for (i = 0; i < XRT_DEVCTL_MAX; i++) {
>> +             if (devctl->base_addrs[i])
>> +                     iounmap(devctl->base_addrs[i]);
>> +     }
>> +
>> +     platform_set_drvdata(pdev, NULL);
>> +     devm_kfree(&pdev->dev, devctl);
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_devctl_probe(struct platform_device *pdev)
>> +{
>> +     struct xrt_devctl       *devctl;
>> +     int                     i, id, ret = 0;
>> +     struct resource         *res;
>> +
>> +     devctl = devm_kzalloc(&pdev->dev, sizeof(*devctl), GFP_KERNEL);
>> +     if (!devctl)
>> +             return -ENOMEM;
>> +
>> +     devctl->pdev = pdev;
>> +     platform_set_drvdata(pdev, devctl);
>> +
>> +     xrt_info(pdev, "probing...");
>> +     for (i = 0, res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +         res;
>> +         res = platform_get_resource(pdev, IORESOURCE_MEM, ++i)) {
>> +             id = xrt_devctl_name2id(devctl, res->name);
>> +             if (id < 0) {
>> +                     xrt_err(pdev, "ep %s not found", res->name);
>> +                     continue;
>> +             }
>> +             devctl->base_addrs[id] = ioremap(res->start, res->end - res->start + 1);
>> +             if (!devctl->base_addrs[id]) {
>> +                     xrt_err(pdev, "map base failed %pR", res);
>> +                     ret = -EIO;
>> +                     goto failed;
>> +             }
>> +             devctl->sizes[id] = res->end - res->start + 1;
>> +     }
>> +
>> +failed:
>> +     if (ret)
>> +             xrt_devctl_remove(pdev);
>> +
>> +     return ret;
>> +}
>> +
>> +static struct xrt_subdev_endpoints xrt_devctl_endpoints[] = {
>> +     {
>> +             .xse_names = (struct xrt_subdev_ep_names[]) {
>> +                     /* add name if ep is in same partition */
>> +                     { .ep_name = XRT_MD_NODE_BLP_ROM },
>> +                     { NULL },
>> +             },
>> +             .xse_min_ep = 1,
>> +     },
>> +     {
>> +             .xse_names = (struct xrt_subdev_ep_names[]) {
>> +                     { .ep_name = XRT_MD_NODE_GOLDEN_VER },
>> +                     { NULL },
>> +             },
>> +             .xse_min_ep = 1,
>> +     },
>> +     /* adding ep bundle generates devctl device instance */
>> +     { 0 },
>> +};
>> +
>> +static struct xrt_subdev_drvdata xrt_devctl_data = {
>> +     .xsd_dev_ops = {
>> +             .xsd_ioctl = xrt_devctl_leaf_ioctl,
>> +     },
>> +};
>> +
>> +static const struct platform_device_id xrt_devctl_table[] = {
>> +     { XRT_DEVCTL, (kernel_ulong_t)&xrt_devctl_data },
>> +     { },
>> +};
>> +
>> +static struct platform_driver xrt_devctl_driver = {
>> +     .driver = {
>> +             .name = XRT_DEVCTL,
>> +     },
>> +     .probe = xrt_devctl_probe,
>> +     .remove = xrt_devctl_remove,
>> +     .id_table = xrt_devctl_table,
>> +};
>> +
>> +void devctl_leaf_init_fini(bool init)
>> +{
>> +     if (init)
>> +             xleaf_register_driver(XRT_SUBDEV_DEVCTL, &xrt_devctl_driver, xrt_devctl_endpoints);
>> +     else
>> +             xleaf_unregister_driver(XRT_SUBDEV_DEVCTL);
>> +}

