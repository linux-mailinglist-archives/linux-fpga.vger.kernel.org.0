Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B6932F44F
	for <lists+linux-fpga@lfdr.de>; Fri,  5 Mar 2021 20:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhCET6t (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 5 Mar 2021 14:58:49 -0500
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:7328
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229679AbhCET6h (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 5 Mar 2021 14:58:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9ajQ6W+BwNSFFy6m/aeDssDshlbe/+XAFPy8QYtJp+OnOvtJcpCxRFGIq719xqXA2od5sDW54mgRIwFYNMZx+MGQ3vuWuAefpeBKyGvOA7vi3JVFc1lSHNkJoylrklE+MqP276g41VqpsmQa0QhMOb/fOxfVxx1NqaJxD79vvOuv4/3jq6tIvHvR7Zxbq5C9r0DSYxcQ6fbJ7bEbzyPuZ7tLYcSfe7jb6qnxoWbx9EXZ485A9F5VJdpDlBXGP19QYUFu9xnOQBG4yzLbOGxNcD6RR+cwKikDa3J8LHX2HbF/pucAVY4M/VyFRMnNtIaCB72HfJXZdk56oiZye7bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIVWVxkG+Q/v73W/Cg/rrL1wqMq9G3GsWxwP1Q6NJ2k=;
 b=Y2AL90nGI1X6HZbaVIGjx0Zmt1vlG61Js5XEYIMWTJTzSoVGyk8FTJLgFZtBU1BTpIbT2v1Tsmte14PpGn6Oxul1bHPdG1IK35wofaXFSioy3xYiolbRud/4BA8WCkGvd3LdJk0ASQBZsA8E/ercJdyjHf5RLe6Zxo55VoXr5jB5WqJALIIdm5FFSd8FPzgvZQt8iwjOlS5m+uFxc4D7kJw+eC1zeUzsUuLl+sCaj/R4UEjpHqvZRjv0+oSQTj8MsqdDEKE/90Z1hnsz2z3EYTPvU34qAGCdz7VwEmF1p7o+/dbDAi1mwMAZbseLbnlso1eL3o1MGOuG7HVAHgIPzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIVWVxkG+Q/v73W/Cg/rrL1wqMq9G3GsWxwP1Q6NJ2k=;
 b=Tx+dLEShJMGpjlQFujfPCqErEvmvywUZ9Q8SwZolPbll/eQHDsee9I9NX0OCPk9IQHjqvz5kpWSElDRSE08ajjyP5vVzEfrnOAsxy+zd4lUgi9Jw0KlQiP9YSz338jpX+rsP/tHmVbl6xBlFalceMXL58AQkamKHVDVKaoXZC8c=
Received: from BLAPR03CA0013.namprd03.prod.outlook.com (2603:10b6:208:32b::18)
 by SN6PR02MB5293.namprd02.prod.outlook.com (2603:10b6:805:6a::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Fri, 5 Mar
 2021 19:58:35 +0000
Received: from BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32b:cafe::6e) by BLAPR03CA0013.outlook.office365.com
 (2603:10b6:208:32b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Fri, 5 Mar 2021 19:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT026.mail.protection.outlook.com (10.152.77.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Fri, 5 Mar 2021 19:58:34 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 5 Mar 2021 11:58:26 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 5 Mar 2021 11:58:26 -0800
Envelope-to: maxz@xilinx.com,
 max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhi.hou@xilinx.com,
 stefanos@xilinx.com,
 robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=57102)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lIGaf-0001zg-UZ; Fri, 05 Mar 2021 11:58:25 -0800
Subject: Re: [PATCH V3 XRT Alveo 10/18] fpga: xrt: VSEC platform driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-11-lizhih@xilinx.com>
 <c574bbef-0165-22dd-f567-0be9f9819676@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <e6ed0d0d-7ac1-cde9-7ed5-ae2bf8991a49@xilinx.com>
Date:   Fri, 5 Mar 2021 11:58:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <c574bbef-0165-22dd-f567-0be9f9819676@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12588806-c078-4fb4-842f-08d8e0110f68
X-MS-TrafficTypeDiagnostic: SN6PR02MB5293:
X-Microsoft-Antispam-PRVS: <SN6PR02MB5293193082E1042BD9561317A1969@SN6PR02MB5293.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t9xcWOgOosRoBKm8E/aPDzkZPM5/fnyCDXbVAJ7iv2jsU+cIJcP8LXw9UOUI7t+3AAGhmXlppVCRjcr0via9dDSJv8DBV3fDDV3zPoM6SHZrhSzF2T0EEJPn9IkVqjJWxP7KSOAByEJ03qaXoKAtTac3OvmWUx+PEbXX4+pPpWmuOS2Hof+M93kIjGkSaYFa1QIE8Ph1VVlC11Gwyf19uaHkq1dmmLbg3vg4MXf8Cyderph0Iyv6ynrmV8TaZcshUBolJ3RbV71hkD+oGS6HQqAw0qRDzdB1zd7GYjd4rLefnJq6ZGrPylzyz/tQdKoeJhNBGosbB7XCBTTEVDdMB3hToLVo+QZRqSRcfvRxl0HClMUocb+sYVwQfVisxjM+p+PE4OyhG+IthCV8kjQlYCeio/VdzZB2OCMhwrVwSZQxNDOwThiD6PG7Hl7EvfXPHg9hVJ7/QpFTlb6A92DRzhBdcRRFaotKViAn6N/co1oJPjRmDhHJV4TgrPNZWPmwp5uRNXtU3fiCOB6XAZoMrDL7jCdKV0is7Zlgvq0UnNEc+vTUNoaVS95aV8Y+h7N2MsHWPk+l5rqtL9bFLEdtDPgIBLhlgonN4/2ap00rsYVeXMTAoxpxX/W08Xjty6W/d3sdqOI60OvUuwbznQP+iQhZdBMS1lvGNWxtRbGdQTN+ZvZLfxjuN1ze6oHrdyXSwv8mtu9kLZfBa6r9y/wvEmVdyA73wJxnLtN9II59qQY=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(46966006)(36840700001)(83380400001)(31696002)(8676002)(356005)(7636003)(478600001)(5660300002)(70206006)(70586007)(36860700001)(26005)(336012)(47076005)(36756003)(31686004)(53546011)(9786002)(426003)(186003)(4326008)(36906005)(30864003)(2616005)(2906002)(44832011)(54906003)(107886003)(316002)(8936002)(82740400003)(82310400003)(110136005)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 19:58:34.9069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12588806-c078-4fb4-842f-08d8e0110f68
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5293
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 03/01/2021 11:01 AM, Tom Rix wrote:
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> Add VSEC driver. VSEC is a hardware function discovered by walking
>> PCI Express configure space. A platform device node will be created
>> for it. VSEC provides board logic UUID and few offset of other hardware
>> functions.
> Is this vsec walking infra or is a general find a list of mmio regions that need to be mapped in and do the mapping in as a set of platform drivers ?
vsec is pointed by PCIe vender-specific capability. And vsec itself 
locates on PCI BAR. vsec has a list of minimum IPs (mmio regions) 
required for driver to load firmware and communicate with the other pcie 
function. After firmware is loaded, xrt will look into the fireware 
metadata to get the information of rest IPs.
vsec  driver notifies the root driver for the list of minimum IPs been 
discovered. Then the root driver will create platform device nodes and 
bring up drivers based on vsec's notification.
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/lib/xleaf/vsec.c | 359 ++++++++++++++++++++++++++++++
>>   1 file changed, 359 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>>
>> diff --git a/drivers/fpga/xrt/lib/xleaf/vsec.c b/drivers/fpga/xrt/lib/xleaf/vsec.c
>> new file mode 100644
>> index 000000000000..8e5cb22522ec
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/xleaf/vsec.c
>> @@ -0,0 +1,359 @@
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
> Type of devices, this list can not grow much.
Because vsec only contains minimum required IPs for loading firmware and 
communication. The list will only change when there is major hardware 
change.
>> +
>> +#define VSEC_UUID_LEN                16
>> +
>> +struct xrt_vsec_header {
>> +     u32             format;
>> +     u32             length;
>> +     u32             entry_sz;
>> +     u32             rsvd;
>> +} __packed;
>> +
>> +#define head_rd(g, r)                        \
>> +     ioread32((void *)(g)->base + offsetof(struct xrt_vsec_header, r))
>> +
>> +#define GET_BAR(entry)       (((entry)->bar_rev >> 4) & 0xf)
>> +#define GET_BAR_OFF(_entry)                          \
>> +     ({ typeof(_entry) entry = (_entry);             \
>> +      ((entry)->off_lo | ((u64)(entry)->off_hi << 16)); })
> A 48 bit value stored in xrt_md_endpoint.bar_off (long)
>
> bar_off should be u64
Will fix this.
>
>> +#define GET_REV(entry)       ((entry)->bar_rev & 0xf)
>> +
> I prefer functions over macros.
Will change to inline function.
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
>> +#define read_entry(g, i, e)                                  \
>> +     do {                                                    \
>> +             u32 *p = (u32 *)((g)->base +                    \
>> +                     sizeof(struct xrt_vsec_header) +        \
>> +                     (i) * sizeof(struct xrt_vsec_entry));   \
>> +             u32 off;                                        \
>> +             for (off = 0;                                   \
>> +                 off < sizeof(struct xrt_vsec_entry) / 4;    \
>> +                 off++)                                      \
>> +                     *((u32 *)(e) + off) = ioread32(p + off);\
>> +     } while (0)
> This could be a static inline func.
Will change to inline function.
>> +
>> +struct vsec_device {
>> +     u8              type;
>> +     char            *ep_name;
>> +     ulong           size;
>> +     char            *regmap;
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
> This is a static list, how would a new type be added to this ?
Because the list will only change when there is major hardware change, 
the list will be update manually if hardware introduces a new type.
>> +};
>> +
>> +struct xrt_vsec {
>> +     struct platform_device  *pdev;
>> +     void                    *base;
>> +     ulong                   length;
>> +
>> +     char                    *metadata;
>> +     char                    uuid[VSEC_UUID_LEN];
>> +};
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
> are multiple uuid types allowed ?
No. And there will be only one uuid in vsec list.
>
> this says assume 1, but logic will recreate 1+
>
> can you check if a mbx ep exists before creating ?
Maybe the comment is confusing. All current Alveo boards only have one 
mailbox in vsec list. In theory, there could be more than 1 mailboxes in 
the future. And how it will present in vsec list is undetermined.
>
>> +
>> +     snprintf(regmap_ver, sizeof(regmap_ver) - 1, "%d-%d.%d.%d",
>> +              p_entry->ver_type, p_entry->major, p_entry->minor,
>> +              GET_REV(p_entry));
>> +     ep.ep_name = type2epname(p_entry->type);
>> +     ep.bar = GET_BAR(p_entry);
>> +     ep.bar_off = GET_BAR_OFF(p_entry);
> here is the bar_off type overlow
Will fix it.
>> +     ep.size = type2size(p_entry->type);
>> +     ep.regmap = type2regmap(p_entry->type);
>> +     ep.regmap_ver = regmap_ver;
>> +     ret = xrt_md_add_endpoint(DEV(vsec->pdev), vsec->metadata, &ep);
>> +     if (ret) {
>> +             xrt_err(vsec->pdev, "add ep failed, ret %d", ret);
>> +             goto failed;
>> +     }
>> +
>> +failed:
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
>> +             read_entry(vsec, i, &entry);
>> +             xrt_vsec_add_node(vsec, vsec->metadata, &entry);
> This can fail.
Will add check.
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_vsec_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
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
> This function looks like a noop.  Is anything going to be added to this later ?
It could be. And there are broadcast events can reach to this handler. I 
think it is harmless to ignore and return.
>> +
>> +     return ret;
>> +}
>> +
>> +static int xrt_vsec_mapio(struct xrt_vsec *vsec)
>> +{
>> +     struct xrt_subdev_platdata *pdata = DEV_PDATA(vsec->pdev);
>> +     const u32 *bar;
>> +     const u64 *bar_off;
>> +     struct resource *res = NULL;
>> +     ulong addr;
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
>> +     addr = res->start + (ulong)be64_to_cpu(*bar_off);
> review this type, addr is ulong and bar_off is not.
Will use u64.
>> +
>> +     vsec->base = ioremap(addr, sizeof(struct xrt_vsec_header));
>> +     if (!vsec->base) {
>> +             xrt_err(vsec->pdev, "Map header failed");
>> +             return -EIO;
>> +     }
> why the double call on ioremap ?
>
> just do the last one.
The first ioremap only maps in the header and read out the length of the 
body (mmio list).
Then the next ioremap maps in the body based on the length.
>
>> +
>> +     vsec->length = head_rd(vsec, length);
>> +     iounmap(vsec->base);
>> +     vsec->base = ioremap(addr, vsec->length);
>> +     if (!vsec->base) {
>> +             xrt_err(vsec->pdev, "map failed");
>> +             return -EIO;
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
>> +     if (vsec->base) {
>> +             iounmap(vsec->base);
>> +             vsec->base = NULL;
>> +     }
>> +
>> +     vfree(vsec->metadata);
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_vsec_probe(struct platform_device *pdev)
>> +{
>> +     struct xrt_vsec *vsec;
>> +     int                     ret = 0;
>> +
>> +     vsec = devm_kzalloc(&pdev->dev, sizeof(*vsec), GFP_KERNEL);
>> +     if (!vsec)
>> +             return -ENOMEM;
>> +
>> +     vsec->pdev = pdev;
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
>> +     ret = xleaf_create_group(pdev, vsec->metadata);
>> +     if (ret < 0)
>> +             xrt_err(pdev, "create group failed, ret %d", ret);
>> +     else
>> +             ret = 0;
> why is it just
>
> if (ret)
>
>    fail ?
xleaf_create_group() returns 0 or positive id on success. I will change to

if (ret < 0)
     goto fail;
  return 0

fail:

Thanks,
Lizhi
>
> Tom
>
>> +
>> +failed:
>> +     if (ret)
>> +             xrt_vsec_remove(pdev);
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
>> +             .xsd_ioctl = xrt_vsec_ioctl,
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
>> +void vsec_leaf_init_fini(bool init)
>> +{
>> +     if (init)
>> +             xleaf_register_driver(XRT_SUBDEV_VSEC, &xrt_vsec_driver, xrt_vsec_endpoints);
>> +     else
>> +             xleaf_unregister_driver(XRT_SUBDEV_VSEC);
>> +}

