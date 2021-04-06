Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E82355D5C
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 23:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238037AbhDFVBi (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 17:01:38 -0400
Received: from mail-eopbgr680056.outbound.protection.outlook.com ([40.107.68.56]:1413
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243168AbhDFVBi (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 6 Apr 2021 17:01:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6VXMJgO0c2adtgJWMvBdXP1PMFYinem+51pRir0zRBaj+ymglPvyJOB0tiiaIaRswhvchWip1h8fhmXZnqlbskWUkwc18mKKhuoOJXfNhqBtHy8AW9yhmKc4OgQhIsU58CV7j1khSKRMSCCwwM3XRtTmQ1Hm1FBy7zIkyH/5wuMta+w6pS2KPArOEPAszQH/15UYIsUolfMQ538vpcZgCNo6Shd20VxIbOBVZgoTNsN2Dx54/i5Ouxd6eCNb/U6tXi30dT0rNolyZtbjk3VxjHO/zV7VaEUHL/Tcs6qOvSUPSqWc/S1E9sJGuNrdES4uDR4qCBiNST+Py2z4su3IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkl0g1c/LrHId8AEd3BS2jgwALvjee25pk5q1OaveF4=;
 b=Y0PdNzGmN1wLnF1ezwV08AaawqEg64STvv2VX7N/aWqt55S/4R2IYq7KsJPShhz4s/8dDSRgsGTPa11qEl+DerC14aB1ZLJb1JHGmdGsFTWCNK+0vG3BZhUNNX65WaS2Dtd3DYRwhnc/jPvR9t7rhT7fSuZul7vwlG/wWNuyTiHeLWudPnS92OHM6Jrf2r7WGBSLp5td/pFnNz0wjlsMcvtnAiIqt4OjTb6iXkC0vVmMhC3IT4n7cEJEvy0J6VvbmunqACCsmFzP0Ceb6ddEJ1JDWDb/Lly5O91abNG9419WouiAWtJ4qUjek5DW7m2D4/UIv999HQCbjD3aWPWGjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xkl0g1c/LrHId8AEd3BS2jgwALvjee25pk5q1OaveF4=;
 b=m/KYoxuS2Ybp20YzZ/OEwTxgLzOZL33ljZlA9YMzfsSvKp0TImbgbpeULrcHsa5LVRhnF75Luup4487SyY9R+ZbEDqFWiOx4u6UHOexlWTw0BzNS/UP3Omtm1cCh3S8WyHY9j14etVxQziEu70Wx1qqxVCm7IG3UCPEyHyL7NK8=
Received: from SA0PR11CA0210.namprd11.prod.outlook.com (2603:10b6:806:1bc::35)
 by MWHPR0201MB3609.namprd02.prod.outlook.com (2603:10b6:301:78::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.26; Tue, 6 Apr
 2021 21:01:26 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bc:cafe::97) by SA0PR11CA0210.outlook.office365.com
 (2603:10b6:806:1bc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Tue, 6 Apr 2021 21:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 21:01:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 6 Apr 2021 14:01:22 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 6 Apr 2021 14:01:22 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=41110)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lTsp8-00031m-0B; Tue, 06 Apr 2021 14:01:22 -0700
Subject: Re: [PATCH V4 XRT Alveo 12/20] fpga: xrt: VSEC platform driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <mdf@kernel.org>, <robh@kernel.org>,
        Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-13-lizhi.hou@xilinx.com>
 <d26476fc-e559-72eb-0e6f-decb06ca7227@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <f9d72ff8-a641-2a51-6c5a-3f774e948e2f@xilinx.com>
Date:   Tue, 6 Apr 2021 14:01:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <d26476fc-e559-72eb-0e6f-decb06ca7227@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f56c3a15-8e26-4455-aafe-08d8f93f249d
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3609:
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3609EA673659A46B617C52E6A1769@MWHPR0201MB3609.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h1d9P/Zec+2C+ixa0i7kswNw9dshYzIjn3abTGH5ce4d981CoofAh5X9Vws2r/eCAZe+tf+/8ExpgH4oWEmzj1rANdg6qSXZAkI/2mbrHygrcP7gUaMMjinrivPsjEsWrofIv320VeKXItt6qggTp9zIAatrnTGlWCJ0B0+zxpiqmghbKwABqB75l3reApTBjeZojFJOph/djaWpw/jgSA+DACALgz+cEjzi1QXUu4YuAEN1OwWtqUpRD+Q7Z79VpxlWaTirT0aVUD3C7Mlu3wb4F2CCt8B/XbtAvRmdsosD4ZoXxD2hNJInmVMMlnV03nsO/ksH/g2I9SYb72uYhdL9vest2u0hDuHfnhISCxeWEVmAVFv5YA7oW0aXqyayCTymlnbmCXpSslOJcbc0YwvtIhg9Mpb1CRPJffswt74WIUbbktB6KOiEjC/WVUE25uRJi42lj920WIiRf/4/hqYA9HOYh/676TwpiPIhSnSBSIt55WR4EACrfUvLNi0gHQz4/TRW1fVxyQYLauuDs5sqf64KDJLx/MsfRBr8DpASnIjkVyCv4xgRcDOQmyHT94wp2dyQDvs8xDPWG9WKUsvaxxbw3blCmMX8UgZq9MmiIxoIl4PWVAKMwj+MFrt7UPYqv4N5MtfgE6jAVbnQxQDWoplE8hGoP+DpSDCXRrriXK75KXiI9abkbnnBMZwd6A8E3hCqUqFpuJslbByaj4XeYVLqyY+bwphYBPcp+f9ACySbEaG80GL6nHqd5eFy
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(7636003)(5660300002)(426003)(356005)(186003)(31686004)(110136005)(83380400001)(2616005)(47076005)(36756003)(8676002)(70206006)(82740400003)(31696002)(4326008)(36906005)(9786002)(316002)(54906003)(53546011)(44832011)(2906002)(478600001)(107886003)(26005)(336012)(82310400003)(70586007)(8936002)(36860700001)(30864003)(76704002)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 21:01:26.4694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f56c3a15-8e26-4455-aafe-08d8f93f249d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3609
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org



On 04/02/2021 07:12 AM, Tom Rix wrote:
> CAUTION: This message has originated from an External Source. Please use proper judgment and caution when opening attachments, clicking links, or responding to this email.
>
>
> local use of 'regmap' conflicts with global meaning.
>
> reword local regmap to something else.
Will change local regmap to 'compat'.
>
> On 3/23/21 10:29 PM, Lizhi Hou wrote:
>> Add VSEC driver. VSEC is a hardware function discovered by walking
>> PCI Express configure space. A platform device node will be created
>> for it. VSEC provides board logic UUID and few offset of other hardware
>> functions.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
>> ---
>>   drivers/fpga/xrt/lib/xleaf/vsec.c | 388 ++++++++++++++++++++++++++++++
>>   1 file changed, 388 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>>
>> diff --git a/drivers/fpga/xrt/lib/xleaf/vsec.c b/drivers/fpga/xrt/lib/xleaf/vsec.c
>> new file mode 100644
>> index 000000000000..8595d23f5710
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/xleaf/vsec.c
>> @@ -0,0 +1,388 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo FPGA VSEC Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
>> + */
>> +
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include "metadata.h"
>> +#include "xleaf.h"
>> +
>> +#define XRT_VSEC "xrt_vsec"
>> +
>> +#define VSEC_TYPE_UUID               0x50
>> +#define VSEC_TYPE_FLASH              0x51
>> +#define VSEC_TYPE_PLATINFO   0x52
>> +#define VSEC_TYPE_MAILBOX    0x53
>> +#define VSEC_TYPE_END                0xff
>> +
>> +#define VSEC_UUID_LEN                16
>> +
>> +#define VSEC_REG_FORMAT              0x0
>> +#define VSEC_REG_LENGTH              0x4
>> +#define VSEC_REG_ENTRY               0x8
>> +
>> +struct xrt_vsec_header {
>> +     u32             format;
>> +     u32             length;
>> +     u32             entry_sz;
>> +     u32             rsvd;
>> +} __packed;
>> +
>> +struct xrt_vsec_entry {
>> +     u8              type;
>> +     u8              bar_rev;
>> +     u16             off_lo;
>> +     u32             off_hi;
>> +     u8              ver_type;
>> +     u8              minor;
>> +     u8              major;
>> +     u8              rsvd0;
>> +     u32             rsvd1;
>> +} __packed;
>> +
>> +struct vsec_device {
>> +     u8              type;
>> +     char            *ep_name;
>> +     ulong           size;
>> +     char            *regmap;
> This element should be 'char *name;' as regmap is a different thing.
Will change to 'compat'.
>
>> +};
>> +
>> +static struct vsec_device vsec_devs[] = {
>> +     {
>> +             .type = VSEC_TYPE_UUID,
>> +             .ep_name = XRT_MD_NODE_BLP_ROM,
>> +             .size = VSEC_UUID_LEN,
>> +             .regmap = "vsec-uuid",
>> +     },
>> +     {
>> +             .type = VSEC_TYPE_FLASH,
>> +             .ep_name = XRT_MD_NODE_FLASH_VSEC,
>> +             .size = 4096,
>> +             .regmap = "vsec-flash",
>> +     },
>> +     {
>> +             .type = VSEC_TYPE_PLATINFO,
>> +             .ep_name = XRT_MD_NODE_PLAT_INFO,
>> +             .size = 4,
>> +             .regmap = "vsec-platinfo",
>> +     },
>> +     {
>> +             .type = VSEC_TYPE_MAILBOX,
>> +             .ep_name = XRT_MD_NODE_MAILBOX_VSEC,
>> +             .size = 48,
>> +             .regmap = "vsec-mbx",
>> +     },
>> +};
>> +
>> +static const struct regmap_config vsec_regmap_config = {
>> +     .reg_bits = 32,
>> +     .val_bits = 32,
>> +     .reg_stride = 4,
>> +     .max_register = 0x1000,
> At least 0x1000 could be #define, maybe all.
Will #define all of them.
>> +};
>> +
>> +struct xrt_vsec {
>> +     struct platform_device  *pdev;
>> +     struct regmap           *regmap;
>> +     u32                     length;
>> +
>> +     char                    *metadata;
>> +     char                    uuid[VSEC_UUID_LEN];
>> +     int                     group;
>> +};
>> +
>> +static inline int vsec_read_entry(struct xrt_vsec *vsec, u32 index, struct xrt_vsec_entry *entry)
>> +{
>> +     int ret;
>> +
>> +     ret = regmap_bulk_read(vsec->regmap, sizeof(struct xrt_vsec_header) +
>> +                            index * sizeof(struct xrt_vsec_entry), entry,
>> +                            sizeof(struct xrt_vsec_entry) /
>> +                            vsec_regmap_config.reg_stride);
>> +
>> +     return ret;
>> +}
>> +
>> +static inline u32 vsec_get_bar(struct xrt_vsec_entry *entry)
>> +{
>> +     return ((entry)->bar_rev >> 4) & 0xf;
> The extra () were needed when this was a macro, they aren't now.
>
> remove here and the next 2 functions.
will remove ().
>
>> +}
>> +
>> +static inline u64 vsec_get_bar_off(struct xrt_vsec_entry *entry)
>> +{
>> +     return (entry)->off_lo | ((u64)(entry)->off_hi << 16);
>> +}
>> +
>> +static inline u32 vsec_get_rev(struct xrt_vsec_entry *entry)
>> +{
>> +     return (entry)->bar_rev & 0xf;
>> +}
>> +
>> +static char *type2epname(u32 type)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
>> +             if (vsec_devs[i].type == type)
>> +                     return (vsec_devs[i].ep_name);
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>> +static ulong type2size(u32 type)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
>> +             if (vsec_devs[i].type == type)
>> +                     return (vsec_devs[i].size);
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static char *type2regmap(u32 type)
>> +{
>> +     int i;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(vsec_devs); i++) {
>> +             if (vsec_devs[i].type == type)
>> +                     return (vsec_devs[i].regmap);
>> +     }
>> +
>> +     return NULL;
>> +}
>> +
>> +static int xrt_vsec_add_node(struct xrt_vsec *vsec,
>> +                          void *md_blob, struct xrt_vsec_entry *p_entry)
>> +{
>> +     struct xrt_md_endpoint ep;
>> +     char regmap_ver[64];
>> +     int ret;
>> +
>> +     if (!type2epname(p_entry->type))
>> +             return -EINVAL;
>> +
>> +     /*
>> +      * VSEC may have more than 1 mailbox instance for the card
>> +      * which has more than 1 physical function.
>> +      * This is not supported for now. Assuming only one mailbox
>> +      */
>> +
>> +     snprintf(regmap_ver, sizeof(regmap_ver) - 1, "%d-%d.%d.%d",
>> +              p_entry->ver_type, p_entry->major, p_entry->minor,
>> +              vsec_get_rev(p_entry));
>> +     ep.ep_name = type2epname(p_entry->type);
>> +     ep.bar = vsec_get_bar(p_entry);
>> +     ep.bar_off = vsec_get_bar_off(p_entry);
> ok
>> +     ep.size = type2size(p_entry->type);
>> +     ep.regmap = type2regmap(p_entry->type);
>> +     ep.regmap_ver = regmap_ver;
>> +     ret = xrt_md_add_endpoint(DEV(vsec->pdev), vsec->metadata, &ep);
>> +     if (ret)
>> +             xrt_err(vsec->pdev, "add ep failed, ret %d", ret);
>> +
>> +     return ret;
>> +}
>> +
>> +static int xrt_vsec_create_metadata(struct xrt_vsec *vsec)
>> +{
>> +     struct xrt_vsec_entry entry;
>> +     int i, ret;
>> +
>> +     ret = xrt_md_create(&vsec->pdev->dev, &vsec->metadata);
>> +     if (ret) {
>> +             xrt_err(vsec->pdev, "create metadata failed");
>> +             return ret;
>> +     }
>> +
>> +     for (i = 0; i * sizeof(entry) < vsec->length -
>> +         sizeof(struct xrt_vsec_header); i++) {
>> +             ret = vsec_read_entry(vsec, i, &entry);
>> +             if (ret) {
>> +                     xrt_err(vsec->pdev, "failed read entry %d, ret %d", i, ret);
>> +                     goto fail;
>> +             }
>> +
>> +             if (entry.type == VSEC_TYPE_END)
>> +                     break;
>> +             ret = xrt_vsec_add_node(vsec, vsec->metadata, &entry);
>> +             if (ret)
>> +                     goto fail;
> ok
>> +     }
>> +
>> +     return 0;
>> +
>> +fail:
>> +     vfree(vsec->metadata);
>> +     vsec->metadata = NULL;
>> +     return ret;
>> +}
>> +
>> +static int xrt_vsec_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
>> +{
>> +     int ret = 0;
>> +
>> +     switch (cmd) {
>> +     case XRT_XLEAF_EVENT:
>> +             /* Does not handle any event. */
>> +             break;
>> +     default:
>> +             ret = -EINVAL;
>> +             xrt_err(pdev, "should never been called");
>> +             break;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int xrt_vsec_mapio(struct xrt_vsec *vsec)
>> +{
>> +     struct xrt_subdev_platdata *pdata = DEV_PDATA(vsec->pdev);
>> +     struct resource *res = NULL;
>> +     void __iomem *base = NULL;
>> +     const u64 *bar_off;
>> +     const u32 *bar;
>> +     u64 addr;
> ok
>> +     int ret;
>> +
>> +     if (!pdata || xrt_md_size(DEV(vsec->pdev), pdata->xsp_dtb) == XRT_MD_INVALID_LENGTH) {
>> +             xrt_err(vsec->pdev, "empty metadata");
>> +             return -EINVAL;
>> +     }
>> +
>> +     ret = xrt_md_get_prop(DEV(vsec->pdev), pdata->xsp_dtb, XRT_MD_NODE_VSEC,
>> +                           NULL, XRT_MD_PROP_BAR_IDX, (const void **)&bar, NULL);
>> +     if (ret) {
>> +             xrt_err(vsec->pdev, "failed to get bar idx, ret %d", ret);
>> +             return -EINVAL;
>> +     }
>> +
>> +     ret = xrt_md_get_prop(DEV(vsec->pdev), pdata->xsp_dtb, XRT_MD_NODE_VSEC,
>> +                           NULL, XRT_MD_PROP_OFFSET, (const void **)&bar_off, NULL);
>> +     if (ret) {
>> +             xrt_err(vsec->pdev, "failed to get bar off, ret %d", ret);
>> +             return -EINVAL;
>> +     }
>> +
>> +     xrt_info(vsec->pdev, "Map vsec at bar %d, offset 0x%llx",
>> +              be32_to_cpu(*bar), be64_to_cpu(*bar_off));
>> +
>> +     xleaf_get_barres(vsec->pdev, &res, be32_to_cpu(*bar));
>> +     if (!res) {
>> +             xrt_err(vsec->pdev, "failed to get bar addr");
>> +             return -EINVAL;
>> +     }
>> +
>> +     addr = res->start + be64_to_cpu(*bar_off);
>> +
>> +     base = devm_ioremap(&vsec->pdev->dev, addr, vsec_regmap_config.max_register);
>> +     if (!base) {
>> +             xrt_err(vsec->pdev, "Map failed");
>> +             return -EIO;
>> +     }
>> +
>> +     vsec->regmap = devm_regmap_init_mmio(&vsec->pdev->dev, base, &vsec_regmap_config);
>> +     if (IS_ERR(vsec->regmap)) {
>> +             xrt_err(vsec->pdev, "regmap %pR failed", res);
>> +             return PTR_ERR(vsec->regmap);
>> +     }
>> +
>> +     ret = regmap_read(vsec->regmap, VSEC_REG_LENGTH, &vsec->length);
>> +     if (ret) {
>> +             xrt_err(vsec->pdev, "failed to read length %d", ret);
>> +             return ret;
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_vsec_remove(struct platform_device *pdev)
>> +{
>> +     struct xrt_vsec *vsec;
>> +
>> +     vsec = platform_get_drvdata(pdev);
>> +
>> +     if (vsec->group >= 0)
>> +             xleaf_destroy_group(pdev, vsec->group);
>> +     vfree(vsec->metadata);
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_vsec_probe(struct platform_device *pdev)
>> +{
>> +     struct xrt_vsec *vsec;
>> +     int ret = 0;
>> +
>> +     vsec = devm_kzalloc(&pdev->dev, sizeof(*vsec), GFP_KERNEL);
>> +     if (!vsec)
>> +             return -ENOMEM;
>> +
>> +     vsec->pdev = pdev;
>> +     vsec->group = -1;
>> +     platform_set_drvdata(pdev, vsec);
>> +
>> +     ret = xrt_vsec_mapio(vsec);
>> +     if (ret)
>> +             goto failed;
>> +
>> +     ret = xrt_vsec_create_metadata(vsec);
>> +     if (ret) {
>> +             xrt_err(pdev, "create metadata failed, ret %d", ret);
>> +             goto failed;
>> +     }
>> +     vsec->group = xleaf_create_group(pdev, vsec->metadata);
>> +     if (ret < 0) {
> this is a bug, ret is not set by xleaf_create_group
Will fix it.

Lizhi
>
> Tom
>
>> +             xrt_err(pdev, "create group failed, ret %d", vsec->group);
>> +             ret = vsec->group;
>> +             goto failed;
>> +     }
>> +
>> +     return 0;
>> +
>> +failed:
>> +     xrt_vsec_remove(pdev);
>> +
>> +     return ret;
>> +}
>> +
>> +static struct xrt_subdev_endpoints xrt_vsec_endpoints[] = {
>> +     {
>> +             .xse_names = (struct xrt_subdev_ep_names []){
>> +                     { .ep_name = XRT_MD_NODE_VSEC },
>> +                     { NULL },
>> +             },
>> +             .xse_min_ep = 1,
>> +     },
>> +     { 0 },
>> +};
>> +
>> +static struct xrt_subdev_drvdata xrt_vsec_data = {
>> +     .xsd_dev_ops = {
>> +             .xsd_leaf_call = xrt_vsec_leaf_call,
>> +     },
>> +};
>> +
>> +static const struct platform_device_id xrt_vsec_table[] = {
>> +     { XRT_VSEC, (kernel_ulong_t)&xrt_vsec_data },
>> +     { },
>> +};
>> +
>> +static struct platform_driver xrt_vsec_driver = {
>> +     .driver = {
>> +             .name = XRT_VSEC,
>> +     },
>> +     .probe = xrt_vsec_probe,
>> +     .remove = xrt_vsec_remove,
>> +     .id_table = xrt_vsec_table,
>> +};
>> +
>> +XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_VSEC, vsec);

