Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B5B32D8FF
	for <lists+linux-fpga@lfdr.de>; Thu,  4 Mar 2021 18:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhCDRvk (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 4 Mar 2021 12:51:40 -0500
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:9697
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231381AbhCDRvJ (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 4 Mar 2021 12:51:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2D3cF+S/U+3YXHWiwFc9FrHhogc7cn15f63ZlZS/q+T9sQ9nwB69tCaukot1nzdVeE+EWdBp7Tk0EljR5zsOw5SC6fFgD95/tO7gNGKpaY+vS8jedC78BJjhtp80IKAKSGx+ut98Io7MnEZshzNy5cDoyG/EU5otwVAB1byXKLA/KoV5eBxHtP0NafgumupHe9n5z4evNgA6NzevDaqxfCon1RUdbXqt5fqWlGw+JQqqSFeChAeuzr35XZ39GSNMSWDeGjx/JyQTZhjQmKDLVCDkcirJMof/w476sb7G3S0PuLsCg/qgTMmKFEp16ubth6VxXgvFYNcVM8UgnPInw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//iLQ5he+f/H8VV5VLHVQPVybEu/gw4+wtSVR4i8nP8=;
 b=eVb9EB2SzHl7wVxojZXRBH3kTE9IWxYHnEQL2GQw/OY8NPF4XLgXQtJvvg+NpzgviIt5PwizMsNHq2DTc0qSEXteMr85E244gtQzphWCLFMB715A1CxAwMZorX0WBuiReBQlw0H9PipY8i1dK33ig5awJrm8Bj2dWRmeXctvzZ7xHCmFO1Q8WuJCRzj6p7ba2V0zGMkupHF++PfmF+QkkExV7cUWV7tkIEhSWoFIYxLqmScHSpLUmrNsWq4r/VG0UflkKY6Xw5rjrA4xJE0ac9u+WTQcSSoQ++FvrvDERF+mkAzhHPQIhKtLsyfWHACfBOPB87fGh7CVpXmUuRMn/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//iLQ5he+f/H8VV5VLHVQPVybEu/gw4+wtSVR4i8nP8=;
 b=MSZCgZJvhQc/vmcS/r0WSRkrKqX5o4wS6Dxo9z/mrC37vi/+FnGJIgZRxCCR2ZlwNexojOyyv5yUi25J1++0RdGFB+9goUH+IBeSnVth72PaD5OTx5cEbHJzL1MnDmU/sFVBjr6c0LxllVLH73CnT1J7zEQ4m9iDhStRGVHZ+CI=
Received: from BL0PR0102CA0007.prod.exchangelabs.com (2603:10b6:207:18::20) by
 BN7PR02MB5283.namprd02.prod.outlook.com (2603:10b6:408:30::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Thu, 4 Mar 2021 17:50:10 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:18:cafe::6d) by BL0PR0102CA0007.outlook.office365.com
 (2603:10b6:207:18::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 17:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 4 Mar 2021 17:50:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 4 Mar 2021 09:50:08 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 4 Mar 2021 09:50:08 -0800
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
Received: from [10.17.2.60] (port=54690)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lHs6y-00027I-Lv; Thu, 04 Mar 2021 09:50:08 -0800
Subject: Re: [PATCH V3 XRT Alveo 09/18] fpga: xrt: fpga-mgr and region
 implementation for xclbin download
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-10-lizhih@xilinx.com>
 <bebfc250-fef3-3f92-e962-f485fd14110a@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <d5c18d16-f0f8-3bb8-5904-b95c615f23bd@xilinx.com>
Date:   Thu, 4 Mar 2021 09:50:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <bebfc250-fef3-3f92-e962-f485fd14110a@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efca3b78-4bcd-42f5-2579-08d8df35f4d5
X-MS-TrafficTypeDiagnostic: BN7PR02MB5283:
X-Microsoft-Antispam-PRVS: <BN7PR02MB52832699755FBA375486B182A1979@BN7PR02MB5283.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1186;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z1p1gD78jG8PpMIirn1CZ0vmbF/phFSkx4X2n0LEeFGxiD9mdI2i6ngEBUK67H/bJNFRBvGa/gfVsWedrWNjHtFw1RfP7A8lL5GkUbZ2BbC3XomnkTUmR1gMhE/GNIWzQ8l+lcjop698qjMhzxWSD30nI4L44BhKr3PWSDYbj12ChqHLyx3bzgQ4wrUHgzkF+XUG6q3Y45h1Ij1REZaasYaZLYPLJUzMok+vnWSM1zYT+MCuH0v1Qqhtd6uBAezqma4cBqhd1MhnFuvKSLCytPqBKGAawD16ziMqxqT/OC97QLgD21vUpif5p+Bt7mfBA68ySiProrFhDYJYSh0yOrtgyzY6ClqWnyhkVpPniEyXvhmUtcUGzLcYwB4h4hAg2zvHV0RGvFHCd2e9uwUclct47Ww/iFJv4Kp+d49b8yK3FretQtNBAT2b5Gt8oj4F7Ovie+YDrh1msM+qdyaNYXceVn9BEv4gU8bHlP5gMKTHRQTJkDXH1wHyapbLzYwRc+6Nv/4CVKluOacj/kaI5I63ucVKm3sXuAI2diMaLYs6WvofK+VXKn/gMcdWKJ4vpqLYfvRlSch8MxSHKqGPecDMCqsiq//T2310buulOXe/Wdid0NfGxAqQXl0ml/NxX3vatwQHvbT/qs+oT+RF4ePKrG6Tq7dUqknSsC4CHSFWJ9cFLfTzw0Vu5MFLmBjFXOqYeC90wO5IQG6G00Ihs0ZKfd36Q2BjoyNc2jzE2EtwT6V9+ayY3Kts7QG6n32z
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(5660300002)(30864003)(53546011)(8936002)(107886003)(2906002)(82740400003)(31696002)(4326008)(316002)(8676002)(26005)(36860700001)(186003)(426003)(36756003)(2616005)(44832011)(110136005)(47076005)(36906005)(70206006)(336012)(70586007)(31686004)(54906003)(356005)(478600001)(7636003)(83380400001)(9786002)(82310400003)(50156003)(2304002)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 17:50:10.5396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efca3b78-4bcd-42f5-2579-08d8df35f4d5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5283
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 02/28/2021 08:36 AM, Tom Rix wrote:
>
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> fpga-mgr and region implementation for xclbin download which will be
>> called from main platform driver
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/mgmt/fmgr-drv.c    | 187 +++++++++++
>>   drivers/fpga/xrt/mgmt/fmgr.h        |  28 ++
>>   drivers/fpga/xrt/mgmt/main-region.c | 471 ++++++++++++++++++++++++++++
>>   3 files changed, 686 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/mgmt/fmgr-drv.c
>>   create mode 100644 drivers/fpga/xrt/mgmt/fmgr.h
>>   create mode 100644 drivers/fpga/xrt/mgmt/main-region.c
>>
>> diff --git a/drivers/fpga/xrt/mgmt/fmgr-drv.c b/drivers/fpga/xrt/mgmt/fmgr-drv.c
>> new file mode 100644
>> index 000000000000..a44d35ecdb60
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/fmgr-drv.c
>> @@ -0,0 +1,187 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * FPGA Manager Support for Xilinx Alveo Management Function Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors: Sonal.Santan@xilinx.com
>> + */
>> +
>> +#include <linux/cred.h>
>> +#include <linux/efi.h>
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/module.h>
>> +#include <linux/vmalloc.h>
>> +
>> +#include "xclbin-helper.h"
>> +#include "xleaf.h"
>> +#include "fmgr.h"
>> +#include "xleaf/axigate.h"
>> +#include "xleaf/icap.h"
>> +#include "main-impl.h"
>> +
>> +struct xfpga_class {
>> +     const struct platform_device *pdev;
>> +     char                          name[64];
>> +};
>> +
>> +/*
>> + * xclbin download plumbing -- find the download subsystem, ICAP and
>> + * pass the xclbin for heavy lifting
>> + */
>> +static int xmgmt_download_bitstream(struct platform_device *pdev,
>> +                                 const struct axlf *xclbin)
>> +
>> +{
>> +     struct hw_icap_bit_header bit_header = { 0 };
>> +     struct platform_device *icap_leaf = NULL;
>> +     struct xrt_icap_ioctl_wr arg;
>> +     char *bitstream = NULL;
>> +     u64 bit_len;
>> +     int ret;
>> +
>> +     ret = xrt_xclbin_get_section(xclbin, BITSTREAM, (void **)&bitstream, &bit_len);
>> +     if (ret || !bitstream) {
> !bitstream check is unneeded
Will fix.
>> +             xrt_err(pdev, "bitstream not found");
>> +             return -ENOENT;
>> +     }
>> +     ret = xrt_xclbin_parse_bitstream_header(bitstream,
>> +                                             DMA_HWICAP_BITFILE_BUFFER_SIZE,
>> +                                             &bit_header);
>> +     if (ret) {
>> +             ret = -EINVAL;
>> +             xrt_err(pdev, "invalid bitstream header");
>> +             goto done;
>> +     }
>> +     if (bit_header.header_length + bit_header.bitstream_length > bit_len) {
>> +             ret = -EINVAL;
>> +             xrt_err(pdev, "invalid bitstream length. header %d, bitstream %d, section len %lld",
>> +                     bit_header.header_length, bit_header.bitstream_length, bit_len);
>> +             goto done;
>> +     }
>> +
>> +     icap_leaf = xleaf_get_leaf_by_id(pdev, XRT_SUBDEV_ICAP, PLATFORM_DEVID_NONE);
>> +     if (!icap_leaf) {
>> +             ret = -ENODEV;
>> +             xrt_err(pdev, "icap does not exist");
>> +             xrt_xclbin_free_header(&bit_header);
>> +             goto done;
>> +     }
>> +     arg.xiiw_bit_data = bitstream + bit_header.header_length;
>> +     arg.xiiw_data_len = bit_header.bitstream_length;
>> +     ret = xleaf_ioctl(icap_leaf, XRT_ICAP_WRITE, &arg);
>> +     if (ret)
>> +             xrt_err(pdev, "write bitstream failed, ret = %d", ret);
>> +
>> +     xrt_xclbin_free_header(&bit_header);
> memory leak when something fails and goto done's
Based on comments of previous patch, it does not need allocating extra 
memory in header parsing function. xrt_xclbin_free_header() will be removed.
>> +done:
> previous general problem, use mutliple label in error handling blocks
Will fix this.
>> +     if (icap_leaf)
>> +             xleaf_put_leaf(pdev, icap_leaf);
>> +     vfree(bitstream);
>> +
>> +     return ret;
>> +}
>> +
>> +/*
>> + * There is no HW prep work we do here since we need the full
>> + * xclbin for its sanity check.
>> + */
>> +static int xmgmt_pr_write_init(struct fpga_manager *mgr,
>> +                            struct fpga_image_info *info,
>> +                            const char *buf, size_t count)
>> +{
>> +     const struct axlf *bin = (const struct axlf *)buf;
>> +     struct xfpga_class *obj = mgr->priv;
>> +
>> +     if (!(info->flags & FPGA_MGR_PARTIAL_RECONFIG)) {
>> +             xrt_info(obj->pdev, "%s only supports partial reconfiguration\n", obj->name);
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (count < sizeof(struct axlf))
>> +             return -EINVAL;
>> +
>> +     if (count > bin->m_header.m_length)
>> +             return -EINVAL;
>> +
>> +     xrt_info(obj->pdev, "Prepare download of xclbin %pUb of length %lld B",
>> +              &bin->m_header.uuid, bin->m_header.m_length);
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * The implementation requries full xclbin image before we can start
>> + * programming the hardware via ICAP subsystem. Full image is required
> The full image
Will fix this.
>> + * for checking the validity of xclbin and walking the sections to
>> + * discover the bitstream.
>> + */
>> +static int xmgmt_pr_write(struct fpga_manager *mgr,
>> +                       const char *buf, size_t count)
>> +{
>> +     const struct axlf *bin = (const struct axlf *)buf;
>> +     struct xfpga_class *obj = mgr->priv;
>> +
>> +     if (bin->m_header.m_length != count)
>> +             return -EINVAL;
>> +
>> +     return xmgmt_download_bitstream((void *)obj->pdev, bin);
>> +}
>> +
>> +static int xmgmt_pr_write_complete(struct fpga_manager *mgr,
>> +                                struct fpga_image_info *info)
>> +{
>> +     const struct axlf *bin = (const struct axlf *)info->buf;
>> +     struct xfpga_class *obj = mgr->priv;
>> +
>> +     xrt_info(obj->pdev, "Finished download of xclbin %pUb",
>> +              &bin->m_header.uuid);
>> +     return 0;
>> +}
>> +
>> +static enum fpga_mgr_states xmgmt_pr_state(struct fpga_manager *mgr)
>> +{
>> +     return FPGA_MGR_STATE_UNKNOWN;
> why just this state ?
This is copied from fme_mgr_state(). I think we can defer this and 
return more status when we need them?

>> +}
>> +
>> +static const struct fpga_manager_ops xmgmt_pr_ops = {
>> +     .initial_header_size = sizeof(struct axlf),
>> +     .write_init = xmgmt_pr_write_init,
>> +     .write = xmgmt_pr_write,
>> +     .write_complete = xmgmt_pr_write_complete,
>> +     .state = xmgmt_pr_state,
>> +};
>> +
>> +struct fpga_manager *xmgmt_fmgr_probe(struct platform_device *pdev)
>> +{
>> +     struct xfpga_class *obj = devm_kzalloc(DEV(pdev), sizeof(struct xfpga_class),
>> +                                            GFP_KERNEL);
>> +     struct fpga_manager *fmgr = NULL;
>> +     int ret = 0;
>> +
>> +     if (!obj)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     snprintf(obj->name, sizeof(obj->name), "Xilinx Alveo FPGA Manager");
>> +     obj->pdev = pdev;
>> +     fmgr = fpga_mgr_create(&pdev->dev,
>> +                            obj->name,
>> +                            &xmgmt_pr_ops,
>> +                            obj);
>> +     if (!fmgr)
>> +             return ERR_PTR(-ENOMEM);
>> +
>> +     ret = fpga_mgr_register(fmgr);
>> +     if (ret) {
>> +             fpga_mgr_free(fmgr);
>> +             return ERR_PTR(ret);
>> +     }
>> +     return fmgr;
>> +}
>> +
>> +int xmgmt_fmgr_remove(struct fpga_manager *fmgr)
>> +{
>> +     fpga_mgr_unregister(fmgr);
>> +     return 0;
>> +}
>> diff --git a/drivers/fpga/xrt/mgmt/fmgr.h b/drivers/fpga/xrt/mgmt/fmgr.h
>> new file mode 100644
>> index 000000000000..e1fc033e2542
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/fmgr.h
>> @@ -0,0 +1,28 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for Xilinx Alveo Management Function Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors: Sonal.Santan@xilinx.com
>> + */
>> +
>> +#ifndef _XMGMT_FMGR_H_
>> +#define _XMGMT_FMGR_H_
>> +
>> +#include <linux/fpga/fpga-mgr.h>
>> +#include <linux/mutex.h>
>> +
>> +#include <linux/xrt/xclbin.h>
>> +
>> +enum xfpga_sec_level {
>> +     XFPGA_SEC_NONE = 0,
>> +     XFPGA_SEC_DEDICATE,
>> +     XFPGA_SEC_SYSTEM,
>> +     XFPGA_SEC_MAX = XFPGA_SEC_SYSTEM,
>> +};
> This enum is not used, remove.
Will remove.
>> +
>> +struct fpga_manager *xmgmt_fmgr_probe(struct platform_device *pdev);
>> +int xmgmt_fmgr_remove(struct fpga_manager *fmgr);
>> +
>> +#endif
>> diff --git a/drivers/fpga/xrt/mgmt/main-region.c b/drivers/fpga/xrt/mgmt/main-region.c
>> new file mode 100644
>> index 000000000000..9779693fe7ae
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/mgmt/main-region.c
>> @@ -0,0 +1,471 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * FPGA Region Support for Xilinx Alveo Management Function Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + * Bulk of the code borrowed from XRT mgmt driver file, fmgr.c
>> + *
>> + * Authors: Lizhi.Hou@xilinx.com
>> + */
>> +
>> +#include <linux/uuid.h>
>> +#include <linux/fpga/fpga-bridge.h>
>> +#include <linux/fpga/fpga-region.h>
>> +#include "metadata.h"
>> +#include "xleaf.h"
>> +#include "xleaf/axigate.h"
>> +#include "xclbin-helper.h"
>> +#include "main-impl.h"
>> +
>> +struct xmgmt_bridge {
>> +     struct platform_device *pdev;
>> +     const char *axigate_name;
> axigate ?
>
> this element could just be 'name'
>
> it seems like 'axigate' means 'bridge', why not use 'bridge' ?
Will change to 'bridge'
>
>> +};
>> +
>> +struct xmgmt_region {
>> +     struct platform_device *pdev;
>> +     struct fpga_region *fregion;
>> +     uuid_t intf_uuid;
>> +     struct fpga_bridge *fbridge;
>> +     int grp_inst;
>> +     uuid_t dep_uuid;
>> +     struct list_head list;
> clean up element names
>
> fregion -> region
>
> grp_inst -> group_instance
>
> ect.
Will fix this.
>
>> +};
>> +
>> +struct xmgmt_region_match_arg {
>> +     struct platform_device *pdev;
>> +     uuid_t *uuids;
>> +     u32 uuid_num;
>> +};
>> +
>> +static int xmgmt_br_enable_set(struct fpga_bridge *bridge, bool enable)
>> +{
>> +     struct xmgmt_bridge *br_data = (struct xmgmt_bridge *)bridge->priv;
>> +     struct platform_device *axigate_leaf;
>> +     int rc;
>> +
>> +     axigate_leaf = xleaf_get_leaf_by_epname(br_data->pdev, br_data->axigate_name);
>> +     if (!axigate_leaf) {
>> +             xrt_err(br_data->pdev, "failed to get leaf %s",
>> +                     br_data->axigate_name);
>> +             return -ENOENT;
>> +     }
>> +
>> +     if (enable)
>> +             rc = xleaf_ioctl(axigate_leaf, XRT_AXIGATE_FREE, NULL);
>> +     else
>> +             rc = xleaf_ioctl(axigate_leaf, XRT_AXIGATE_FREEZE, NULL);
>> +
>> +     if (rc) {
>> +             xrt_err(br_data->pdev, "failed to %s gate %s, rc %d",
>> +                     (enable ? "free" : "freeze"), br_data->axigate_name,
>> +                     rc);
>> +     }
>> +
>> +     xleaf_put_leaf(br_data->pdev, axigate_leaf);
>> +
>> +     return rc;
>> +}
>> +
>> +const struct fpga_bridge_ops xmgmt_bridge_ops = {
>> +     .enable_set = xmgmt_br_enable_set
>> +};
>> +
>> +static void xmgmt_destroy_bridge(struct fpga_bridge *br)
>> +{
>> +     struct xmgmt_bridge *br_data = br->priv;
>> +
>> +     if (!br_data)
>> +             return;
>> +
>> +     xrt_info(br_data->pdev, "destroy fpga bridge %s", br_data->axigate_name);
>> +     fpga_bridge_unregister(br);
>> +
>> +     devm_kfree(DEV(br_data->pdev), br_data);
>> +
>> +     fpga_bridge_free(br);
>> +}
>> +
>> +static struct fpga_bridge *xmgmt_create_bridge(struct platform_device *pdev,
>> +                                            char *dtb)
>> +{
>> +     struct xmgmt_bridge *br_data;
>> +     struct fpga_bridge *br = NULL;
>> +     const char *gate;
>> +     int rc;
>> +
>> +     br_data = devm_kzalloc(DEV(pdev), sizeof(*br_data), GFP_KERNEL);
>> +     if (!br_data)
>> +             return NULL;
>> +     br_data->pdev = pdev;
>> +
>> +     br_data->axigate_name = XRT_MD_NODE_GATE_ULP;
>> +     rc = xrt_md_find_endpoint(&pdev->dev, dtb, XRT_MD_NODE_GATE_ULP,
>> +                               NULL, &gate);
>> +     if (rc) {
>> +             br_data->axigate_name = XRT_MD_NODE_GATE_PLP;
>> +             rc = xrt_md_find_endpoint(&pdev->dev, dtb, XRT_MD_NODE_GATE_PLP,
>> +                                       NULL, &gate);
>> +     }
>> +     if (rc) {
>> +             xrt_err(pdev, "failed to get axigate, rc %d", rc);
>> +             goto failed;
>> +     }
>> +
>> +     br = fpga_bridge_create(DEV(pdev), br_data->axigate_name,
>> +                             &xmgmt_bridge_ops, br_data);
>> +     if (!br) {
>> +             xrt_err(pdev, "failed to create bridge");
>> +             goto failed;
>> +     }
>> +
>> +     rc = fpga_bridge_register(br);
>> +     if (rc) {
>> +             xrt_err(pdev, "failed to register bridge, rc %d", rc);
>> +             goto failed;
>> +     }
>> +
>> +     xrt_info(pdev, "created fpga bridge %s", br_data->axigate_name);
>> +
>> +     return br;
>> +
>> +failed:
>> +     if (br)
>> +             fpga_bridge_free(br);
>> +     if (br_data)
>> +             devm_kfree(DEV(pdev), br_data);
>> +
>> +     return NULL;
>> +}
>> +
>> +static void xmgmt_destroy_region(struct fpga_region *re)
> re, to me means regular expression.
>
> can you use 'region' instead ?
Will change this.
>
>> +{
>> +     struct xmgmt_region *r_data = re->priv;
>> +
>> +     xrt_info(r_data->pdev, "destroy fpga region %llx%llx",
> need a sperator here ? between %llx%llx
Will add '.' in between.
>> +              re->compat_id->id_l, re->compat_id->id_h);
>> +
>> +     fpga_region_unregister(re);
>> +
>> +     if (r_data->grp_inst > 0)
>> +             xleaf_destroy_group(r_data->pdev, r_data->grp_inst);
>> +
>> +     if (r_data->fbridge)
>> +             xmgmt_destroy_bridge(r_data->fbridge);
>> +
>> +     if (r_data->fregion->info) {
>> +             fpga_image_info_free(r_data->fregion->info);
>> +             r_data->fregion->info = NULL;
>> +     }
>> +
>> +     fpga_region_free(re);
>> +
>> +     devm_kfree(DEV(r_data->pdev), r_data);
>> +}
>> +
>> +static int xmgmt_region_match(struct device *dev, const void *data)
>> +{
>> +     const struct xmgmt_region_match_arg *arg = data;
>> +     const struct fpga_region *match_re;
>> +     int i;
>> +
>> +     if (dev->parent != &arg->pdev->dev)
>> +             return false;
>> +
>> +     match_re = to_fpga_region(dev);
>> +     /*
>> +      * The device tree provides both parent and child uuids for an
>> +      * xclbin in one array. Here we try both uuids to see if it matches
>> +      * with target region's compat_id. Strictly speaking we should
>> +      * only match xclbin's parent uuid with target region's compat_id
>> +      * but given the uuids by design are unique comparing with both
>> +      * does not hurt.
>> +      */
>> +     for (i = 0; i < arg->uuid_num; i++) {
>> +             if (!memcmp(match_re->compat_id, &arg->uuids[i],
>> +                         sizeof(*match_re->compat_id)))
>> +                     return true;
>> +     }
>> +
>> +     return false;
>> +}
>> +
>> +static int xmgmt_region_match_base(struct device *dev, const void *data)
>> +{
>> +     const struct xmgmt_region_match_arg *arg = data;
>> +     const struct fpga_region *match_re;
>> +     const struct xmgmt_region *r_data;
>> +
>> +     if (dev->parent != &arg->pdev->dev)
>> +             return false;
>> +
>> +     match_re = to_fpga_region(dev);
> me getting confused thinking match_re is 'match regular expression'
Will change to 'match_region'.
>> +     r_data = match_re->priv;
>> +     if (uuid_is_null(&r_data->dep_uuid))
>> +             return true;
>> +
>> +     return false;
>> +}
>> +
>> +static int xmgmt_region_match_by_depuuid(struct device *dev, const void *data)
> what is a dep uuid ?
A region could be on top of another base region. 'dep uuid' means base 
region uuid it depends on.
>
> should add a '_' so function name is xmgmt_region_match_by_dep_uuid()
>
> this is quite long.
Will change to xmgmt_region_match_by_uuid().
>
>> +{
>> +     const struct xmgmt_region_match_arg *arg = data;
>> +     const struct fpga_region *match_re;
>> +     const struct xmgmt_region *r_data;
>> +
>> +     if (dev->parent != &arg->pdev->dev)
>> +             return false;
>> +
>> +     match_re = to_fpga_region(dev);
>> +     r_data = match_re->priv;
>> +     if (!memcmp(&r_data->dep_uuid, arg->uuids, sizeof(uuid_t)))
> arg->uuids is an array
>
> arg->uuid_num is its extent.
>
> should be a loop or check on uuid_num == 1 or both.
Will add check on uuid_num == 1.
>
>> +             return true;
>> +
>> +     return false;
>> +}
>> +
>> +static void xmgmt_region_cleanup(struct fpga_region *re)
>> +{
>> +     struct xmgmt_region *r_data = re->priv, *temp;
>> +     struct platform_device *pdev = r_data->pdev;
>> +     struct fpga_region *match_re = NULL;
>> +     struct device *start_dev = NULL;
>> +     struct xmgmt_region_match_arg arg;
>> +     LIST_HEAD(free_list);
>> +
>> +     list_add_tail(&r_data->list, &free_list);
>> +     arg.pdev = pdev;
>> +     arg.uuid_num = 1;
>> +
>> +     while (!r_data) {
>> +             arg.uuids = (uuid_t *)r_data->fregion->compat_id;
>> +             match_re = fpga_region_class_find(start_dev, &arg,
>> +                                               xmgmt_region_match_by_depuuid);
>> +             if (match_re) {
>> +                     r_data = match_re->priv;
> This setting of r_data and continuing is strange, add a comment.
>
> or if you intend to do a pair of operations, do the pair within the if block and remove the strangeness.
Thanks for pointing it out. This is poor implementation. I will 
re-implement the loop and add comment.
>
>> +                     list_add_tail(&r_data->list, &free_list);
>> +                     start_dev = &match_re->dev;
>> +                     put_device(&match_re->dev);
>> +                     continue;
>> +             }
>> +
>> +             r_data = list_is_last(&r_data->list, &free_list) ? NULL :
>> +                     list_next_entry(r_data, list);
>> +             start_dev = NULL;
>> +     }
>> +
>> +     list_for_each_entry_safe_reverse(r_data, temp, &free_list, list) {
>> +             if (list_is_first(&r_data->list, &free_list)) {
>> +                     if (r_data->grp_inst > 0) {
>> +                             xleaf_destroy_group(pdev, r_data->grp_inst);
>> +                             r_data->grp_inst = -1;
>> +                     }
>> +                     if (r_data->fregion->info) {
>> +                             fpga_image_info_free(r_data->fregion->info);
>> +                             r_data->fregion->info = NULL;
>> +                     }
>> +                     continue;
> add a comment, why is a continue needed here ?
Will remove the continue and pop the first node before the loop.
>> +             }
>> +             xmgmt_destroy_region(r_data->fregion);
>> +     }
>> +}
>> +
>> +void xmgmt_region_cleanup_all(struct platform_device *pdev)
>> +{
>> +     struct fpga_region *base_re;
>> +     struct xmgmt_region_match_arg arg;
>> +
>> +     arg.pdev = pdev;
>> +
>> +     for (base_re = fpga_region_class_find(NULL, &arg, xmgmt_region_match_base);
>> +         base_re;
>> +         base_re = fpga_region_class_find(NULL, &arg, xmgmt_region_match_base)) {
> convert to a while
>
> while (base_region = ... ) {
Will convert.
>
>> +             put_device(&base_re->dev);
>> +
>> +             xmgmt_region_cleanup(base_re);
>> +             xmgmt_destroy_region(base_re);
>> +     }
>> +}
>> +
>> +/*
>> + * Program a given region with given xclbin image. Bring up the subdevs and the
> Program a region with a xclbin image.
Will fix this.
>> + * group object to contain the subdevs.
>> + */
>> +static int xmgmt_region_program(struct fpga_region *re, const void *xclbin, char *dtb)
>> +{
>> +     struct xmgmt_region *r_data = re->priv;
>> +     struct platform_device *pdev = r_data->pdev;
>> +     struct fpga_image_info *info;
>> +     const struct axlf *xclbin_obj = xclbin;
>> +     int rc;
>> +
>> +     info = fpga_image_info_alloc(&pdev->dev);
>> +     if (!info)
>> +             return -ENOMEM;
>> +
>> +     info->buf = xclbin;
>> +     info->count = xclbin_obj->m_header.m_length;
>> +     info->flags |= FPGA_MGR_PARTIAL_RECONFIG;
>> +     re->info = info;
>> +     rc = fpga_region_program_fpga(re);
>> +     if (rc) {
>> +             xrt_err(pdev, "programming xclbin failed, rc %d", rc);
>> +             return rc;
>> +     }
> free info ?
info will be freed outside by xmgmt_destroy_region().
>> +
>> +     /* free bridges to allow reprogram */
>> +     if (re->get_bridges)
>> +             fpga_bridges_put(&re->bridge_list);
>> +
>> +     /*
>> +      * Next bringup the subdevs for this region which will be managed by
>> +      * its own group object.
>> +      */
>> +     r_data->grp_inst = xleaf_create_group(pdev, dtb);
>> +     if (r_data->grp_inst < 0) {
>> +             xrt_err(pdev, "failed to create group, rc %d",
>> +                     r_data->grp_inst);
>> +             rc = r_data->grp_inst;
>> +             return rc;
>> +     }
>> +
>> +     rc = xleaf_wait_for_group_bringup(pdev);
>> +     if (rc)
>> +             xrt_err(pdev, "group bringup failed, rc %d", rc);
> failed but no error handling, shouldn't the leaves and group be torn down ?
Group is torn down outside by xmgmt_destroy_region().
>> +     return rc;
>> +}
>> +
>> +static int xmgmt_get_bridges(struct fpga_region *re)
>> +{
>> +     struct xmgmt_region *r_data = re->priv;
>> +     struct device *dev = &r_data->pdev->dev;
>> +
>> +     return fpga_bridge_get_to_list(dev, re->info, &re->bridge_list);
>> +}
>> +
>> +/*
>> + * Program/create FPGA regions based on input xclbin file. This is key function
>> + * stitching the flow together:
> 'This is ' .. sentence does not make sense, but is not needed drop it.
Will drop it.
>> + * 1. Identify a matching existing region for this xclbin
>> + * 2. Tear down any previous objects for the found region
>> + * 3. Program this region with input xclbin
>> + * 4. Iterate over this region's interface uuids to determine if it defines any
>> + *    child region. Create fpga_region for the child region.
>> + */
>> +int xmgmt_process_xclbin(struct platform_device *pdev,
>> +                      struct fpga_manager *fmgr,
>> +                      const struct axlf *xclbin,
>> +                      enum provider_kind kind)
>> +{
>> +     struct fpga_region *re, *compat_re = NULL;
>> +     struct xmgmt_region_match_arg arg;
> should initialize to { 0 }
Will fix this and few other places.
>> +     struct xmgmt_region *r_data;
>> +     char *dtb = NULL;
>> +     int rc, i;
>> +
>> +     rc = xrt_xclbin_get_metadata(DEV(pdev), xclbin, &dtb);
>> +     if (rc) {
>> +             xrt_err(pdev, "failed to get dtb: %d", rc);
>> +             goto failed;
>> +     }
>> +
>> +     xrt_md_get_intf_uuids(DEV(pdev), dtb, &arg.uuid_num, NULL);
> should also check return and return that error code, it isn't always -EINVAL
Will fix this.
>> +     if (arg.uuid_num == 0) {
>> +             xrt_err(pdev, "failed to get intf uuid");
>> +             rc = -EINVAL;
>> +             goto failed;
>> +     }
>> +     arg.uuids = vzalloc(sizeof(uuid_t) * arg.uuid_num);
>> +     if (!arg.uuids) {
>> +             rc = -ENOMEM;
>> +             goto failed;
>> +     }
>> +     arg.pdev = pdev;
>> +
>> +     xrt_md_get_intf_uuids(DEV(pdev), dtb, &arg.uuid_num, arg.uuids);
> This can still fail, check this return and check the expected num of uuid's has not changed.
Will fix this.
>> +
>> +     /* if this is not base firmware, search for a compatible region */
>> +     if (kind != XMGMT_BLP) {
>> +             compat_re = fpga_region_class_find(NULL, &arg,
>> +                                                xmgmt_region_match);
>> +             if (!compat_re) {
>> +                     xrt_err(pdev, "failed to get compatible region");
>> +                     rc = -ENOENT;
>> +                     goto failed;
>> +             }
>> +
>> +             xmgmt_region_cleanup(compat_re);
>> +
>> +             rc = xmgmt_region_program(compat_re, xclbin, dtb);
>> +             if (rc) {
>> +                     xrt_err(pdev, "failed to program region");
>> +                     goto failed;
>> +             }
>> +     }
>> +
>> +     /* create all the new regions contained in this xclbin */
>> +     for (i = 0; i < arg.uuid_num; i++) {
>> +             if (compat_re && !memcmp(compat_re->compat_id, &arg.uuids[i],
>> +                                      sizeof(*compat_re->compat_id)))
>> +                     /* region for this interface already exists */
>> +                     continue;
>> +             re = fpga_region_create(DEV(pdev), fmgr, xmgmt_get_bridges);
>> +             if (!re) {
>> +                     xrt_err(pdev, "failed to create fpga region");
>> +                     rc = -EFAULT;
>> +                     goto failed;
>> +             }
>> +             r_data = devm_kzalloc(DEV(pdev), sizeof(*r_data), GFP_KERNEL);
>> +             if (!r_data) {
>> +                     rc = -ENOMEM;
>> +                     fpga_region_free(re);
>> +                     goto failed;
> Failed in a loop but no cleanup of previous iterations.
Will fix this.

Thanks,
Lizhi
>
> Tom
>
>> +             }
>> +             r_data->pdev = pdev;
>> +             r_data->fregion = re;
>> +             r_data->grp_inst = -1;
>> +             memcpy(&r_data->intf_uuid, &arg.uuids[i],
>> +                    sizeof(r_data->intf_uuid));
>> +             if (compat_re) {
>> +                     memcpy(&r_data->dep_uuid, compat_re->compat_id,
>> +                            sizeof(r_data->intf_uuid));
>> +             }
>> +             r_data->fbridge = xmgmt_create_bridge(pdev, dtb);
>> +             if (!r_data->fbridge) {
>> +                     xrt_err(pdev, "failed to create fpga bridge");
>> +                     rc = -EFAULT;
>> +                     devm_kfree(DEV(pdev), r_data);
>> +                     fpga_region_free(re);
>> +                     goto failed;
>> +             }
>> +
>> +             re->compat_id = (struct fpga_compat_id *)&r_data->intf_uuid;
>> +             re->priv = r_data;
>> +
>> +             rc = fpga_region_register(re);
>> +             if (rc) {
>> +                     xrt_err(pdev, "failed to register fpga region");
>> +                     xmgmt_destroy_bridge(r_data->fbridge);
>> +                     fpga_region_free(re);
>> +                     devm_kfree(DEV(pdev), r_data);
>> +                     goto failed;
>> +             }
>> +
>> +             xrt_info(pdev, "created fpga region %llx%llx",
>> +                      re->compat_id->id_l, re->compat_id->id_h);
>> +     }
>> +
>> +failed:
>> +     if (compat_re)
>> +             put_device(&compat_re->dev);
>> +
>> +     if (rc) {
>> +             if (compat_re)
>> +                     xmgmt_region_cleanup(compat_re);
>> +     }
>> +
>> +     if (dtb)
>> +             vfree(dtb);
>> +
>> +     return rc;
>> +}

