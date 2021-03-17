Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8548B33FA2E
	for <lists+linux-fpga@lfdr.de>; Wed, 17 Mar 2021 21:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbhCQU5G (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 17 Mar 2021 16:57:06 -0400
Received: from mail-mw2nam12on2059.outbound.protection.outlook.com ([40.107.244.59]:57824
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233416AbhCQU4i (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y0oUSmC5SjOMwBL6uiE8Ro4u9B1eb8+9IhXBu9b6rCbqpnXafy+2FOA7K+0TjMxH5L0/3cIkLHhxT1Zmfz/55gegKI2f0Xu3NSVOsIxsR4sd+V2iBjjzja/41aGTkTXR1e81a1TB7N/UEtUEcw+6DAGWFBfTZpQ4wjhGKRfiiXPfWRJKQD5sAtWczX/jf0J/WkZ87pJZp6HJjDBRLCxhjyWmMp29F9PW/1WgDyJSzciheePm5V8etvcqTMGhyiugfFvzyIqLRDHVtiPqNe6Hm7Keg96KrNX5DzGtsO371Nbp0Rc+dO/qpL8hHmrMecBgmGHzbQOe3GiMqsYcSuzS5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQJOtqpE4qQlTHqmQT3txad1YFM6W7FTd+5vDngzR20=;
 b=Eng1m2Ljl0HlGGDjIo1vn1DpOfWRJ2gi7/s1Q4HdylOZlPd6nQCqtt8QlqURH2EjhrP96OKrSBoMbGze288BSIEhCnWdkatURwE46bbTajpooecLmysLvWlWWpQiRf2+/yRLpl6twQ1GCxrcOHVL1N/jPHAMxz4ReQl6ZElzpxNtwlV3alIYo4ryR42WBChZy9BBayJY7BZ57RJSfmeYwwm8qbzByS1STMLfRh/npcsKQIIi3+ImqHHwFpGIHK0CzMDvTJXsNHMCaN8XEyGvv43j4Sn6HwLKd/N2UcegEwF9U4cPGRop3bHkp5n2ePieVLMRX1ejkWyRW7oq9ot2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQJOtqpE4qQlTHqmQT3txad1YFM6W7FTd+5vDngzR20=;
 b=WbsqoisfOdGUGUtIjKfZ9KMyDJY5GpVLJVKamqYF1cBD+/xHiw/6RWWKseugizzU1Gcbd2m+GNnp8j+Us/zFOkWVo0HT7OP/UAqZ81j925PbBReM8Ec0+7QBoiBmblI/vvPahlYfkr+pAvLf1N24g4UV8arh8CKeWSp3EJpS9MA=
Received: from SN6PR08CA0001.namprd08.prod.outlook.com (2603:10b6:805:66::14)
 by MWHPR02MB2880.namprd02.prod.outlook.com (2603:10b6:300:106::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Wed, 17 Mar
 2021 20:56:35 +0000
Received: from SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:66:cafe::be) by SN6PR08CA0001.outlook.office365.com
 (2603:10b6:805:66::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 17 Mar 2021 20:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT019.mail.protection.outlook.com (10.152.72.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3933.32 via Frontend Transport; Wed, 17 Mar 2021 20:56:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 13:56:32 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Wed, 17 Mar 2021 13:56:32 -0700
Envelope-to: robh@kernel.org,
 mdf@kernel.org,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 trix@redhat.com
Received: from [10.17.2.60] (port=56470)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lMdDU-0001NU-B9; Wed, 17 Mar 2021 13:56:32 -0700
Subject: Re: [PATCH V3 XRT Alveo 12/18] fpga: xrt: ICAP platform driver
To:     Tom Rix <trix@redhat.com>, Lizhi Hou <lizhi.hou@xilinx.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-fpga@vger.kernel.org>, <maxz@xilinx.com>,
        <sonal.santan@xilinx.com>, <michal.simek@xilinx.com>,
        <stefanos@xilinx.com>, <devicetree@vger.kernel.org>,
        <mdf@kernel.org>, <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-13-lizhih@xilinx.com>
 <6bbcff78-cd3b-fad8-157f-f11dc30cad21@redhat.com>
From:   Lizhi Hou <lizhi.hou@xilinx.com>
Message-ID: <2b3cb26a-aeaf-de79-705b-ea2cb679ba31@xilinx.com>
Date:   Wed, 17 Mar 2021 13:56:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <6bbcff78-cd3b-fad8-157f-f11dc30cad21@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45ae5caa-b71f-4f18-782f-08d8e9872673
X-MS-TrafficTypeDiagnostic: MWHPR02MB2880:
X-Microsoft-Antispam-PRVS: <MWHPR02MB288029F1E8025F6B95BB8631A16A9@MWHPR02MB2880.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hKoOKflS6zKnXHhtQSoLEOddpeA9fud1UyOvInxdn6VvQKiFdXowRB1U/Ok8zHqeyYLJ42FAzXa3VCAfA2JucUXbePHpM+Bh+BAAe1KGrqXlN5oQElqBZ1J8KPoFfTAjXJ0lmwJfDzIUyEpd6rp0946T28mmmDxOJAtjWfV8Dwu9d4n/blLkCropth89OxMn+qjeiG0aWDWKpL4xZaZFNs5vrPRXAik9o3md2toHa3dZSymYuVY4DZGi8asAV6OZu0WRfvqU8Est21EXihHeha0uXIXk+i3OMfZtJJny9uHYvUo/brLEs9dfjDA65VIviiVrhqcFrGvp/gLXoPDuxdHFdIGO5nuDYIh00PDVfIOM+wNjwr0l9K4WmMHUol3exw0Io6rXAtlm5KB1vfppmZ5NsfhaCIXD5GVgqcKaKs89imhL7UDsdIXAkoYqU3gxGlaRStAFxBPuAZBDzGMR2HntxeQahyJuhsbjUh1EIhTtwCMAYq5T8Dx/rSRKH+vLanFEUvYToR6ScdAmNsEtHKQDcNyDbtPnQ7li3hkucSpTNI6Ra+OOuTtR6kB3zpCHL7Gjvl5pMc2Oasi4Ki6qCHpTbwTY3R/lbSywaouSVvVdyrkXKwmSFe0vj+o5ieQzahpE34b0ajbSFci9idjTUcf0nvpZLScGnPkNrA3p3NUI+6iUYkCPw+FAkRTIfBjbLuNpggE1VNmO23fCfLC1zmScUaxaswdEABOH89GWdgE=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39860400002)(396003)(46966006)(36840700001)(82740400003)(83380400001)(356005)(31686004)(53546011)(70586007)(44832011)(36756003)(8936002)(107886003)(31696002)(426003)(4326008)(36860700001)(47076005)(8676002)(36906005)(82310400003)(30864003)(186003)(26005)(54906003)(2616005)(70206006)(110136005)(2906002)(7636003)(478600001)(336012)(9786002)(5660300002)(316002)(50156003)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 20:56:34.7070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ae5caa-b71f-4f18-782f-08d8e9872673
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT019.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2880
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Tom,


On 03/03/2021 07:12 AM, Tom Rix wrote:
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
>> Add ICAP driver. ICAP is a hardware function discovered by walking
> What does ICAP stand for ?
ICAP stands for Hardware Internal Configuration Access Port. I will add 
this.
>> firmware metadata. A platform device node will be created for it.
>> FPGA bitstream is written to hardware through ICAP.
>>
>> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
>> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
>> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
>> ---
>>   drivers/fpga/xrt/include/xleaf/icap.h |  29 +++
>>   drivers/fpga/xrt/lib/xleaf/icap.c     | 317 ++++++++++++++++++++++++++
>>   2 files changed, 346 insertions(+)
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>>
>> diff --git a/drivers/fpga/xrt/include/xleaf/icap.h b/drivers/fpga/xrt/include/xleaf/icap.h
>> new file mode 100644
>> index 000000000000..a14fc0ffa78f
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/include/xleaf/icap.h
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Header file for XRT ICAP Leaf Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *   Lizhi Hou <Lizhi.Hou@xilinx.com>
>> + */
>> +
>> +#ifndef _XRT_ICAP_H_
>> +#define _XRT_ICAP_H_
>> +
>> +#include "xleaf.h"
>> +
>> +/*
>> + * ICAP driver IOCTL calls.
>> + */
>> +enum xrt_icap_ioctl_cmd {
>> +     XRT_ICAP_WRITE = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> maybe XRT_ICAP_GET_IDCODE
Sure.
>> +     XRT_ICAP_IDCODE,
>> +};
>> +
>> +struct xrt_icap_ioctl_wr {
>> +     void    *xiiw_bit_data;
>> +     u32     xiiw_data_len;
>> +};
>> +
>> +#endif       /* _XRT_ICAP_H_ */
>> diff --git a/drivers/fpga/xrt/lib/xleaf/icap.c b/drivers/fpga/xrt/lib/xleaf/icap.c
>> new file mode 100644
>> index 000000000000..0500a97bdef9
>> --- /dev/null
>> +++ b/drivers/fpga/xrt/lib/xleaf/icap.c
>> @@ -0,0 +1,317 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Xilinx Alveo FPGA ICAP Driver
>> + *
>> + * Copyright (C) 2020-2021 Xilinx, Inc.
>> + *
>> + * Authors:
>> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
>> + *      Sonal Santan <sonals@xilinx.com>
>> + *      Max Zhen <maxz@xilinx.com>
>> + */
>> +
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/io.h>
>> +#include "metadata.h"
>> +#include "xleaf.h"
>> +#include "xleaf/icap.h"
>> +#include "xclbin-helper.h"
>> +
>> +#define XRT_ICAP "xrt_icap"
>> +
>> +#define ICAP_ERR(icap, fmt, arg...)  \
>> +     xrt_err((icap)->pdev, fmt "\n", ##arg)
>> +#define ICAP_WARN(icap, fmt, arg...) \
>> +     xrt_warn((icap)->pdev, fmt "\n", ##arg)
>> +#define ICAP_INFO(icap, fmt, arg...) \
>> +     xrt_info((icap)->pdev, fmt "\n", ##arg)
>> +#define ICAP_DBG(icap, fmt, arg...)  \
>> +     xrt_dbg((icap)->pdev, fmt "\n", ##arg)
>> +
>> +/*
>> + * AXI-HWICAP IP register layout
>> + */
>> +struct icap_reg {
>> +     u32     ir_rsvd1[7];
>> +     u32     ir_gier;
>> +     u32     ir_isr;
>> +     u32     ir_rsvd2;
>> +     u32     ir_ier;
>> +     u32     ir_rsvd3[53];
>> +     u32     ir_wf;
>> +     u32     ir_rf;
>> +     u32     ir_sz;
>> +     u32     ir_cr;
>> +     u32     ir_sr;
>> +     u32     ir_wfv;
>> +     u32     ir_rfo;
>> +     u32     ir_asr;
>> +} __packed;
>> +
>> +struct icap {
>> +     struct platform_device  *pdev;
>> +     struct icap_reg         *icap_regs;
>> +     struct mutex            icap_lock; /* icap dev lock */
>> +
>> +     unsigned int            idcode;
> returned as a 64 bit value, but could be stored as 32 bit
Will change return to u32.
>> +};
>> +
>> +static inline u32 reg_rd(void __iomem *reg)
>> +{
>> +     if (!reg)
>> +             return -1;
>> +
>> +     return ioread32(reg);
> Look at converting the io access to using regmap* api
Will change it.
>> +}
>> +
>> +static inline void reg_wr(void __iomem *reg, u32 val)
>> +{
>> +     if (!reg)
>> +             return;
>> +
>> +     iowrite32(val, reg);
>> +}
>> +
>> +static int wait_for_done(struct icap *icap)
>> +{
>> +     u32     w;
>> +     int     i = 0;
>> +
>> +     WARN_ON(!mutex_is_locked(&icap->icap_lock));
> is this needed ? wait_for_done is only called in one place.
Will remove it.
>> +     for (i = 0; i < 10; i++) {
>> +             udelay(5);
> comment on delay.
>> +             w = reg_rd(&icap->icap_regs->ir_sr);
>> +             ICAP_INFO(icap, "XHWICAP_SR: %x", w);
>> +             if (w & 0x5)
> 0x5 is a magic number, should be #defined
Sure.
>> +                     return 0;
>> +     }
>> +
>> +     ICAP_ERR(icap, "bitstream download timeout");
>> +     return -ETIMEDOUT;
>> +}
>> +
>> +static int icap_write(struct icap *icap, const u32 *word_buf, int size)
>> +{
>> +     int i;
>> +     u32 value = 0;
>> +
>> +     for (i = 0; i < size; i++) {
>> +             value = be32_to_cpu(word_buf[i]);
>> +             reg_wr(&icap->icap_regs->ir_wf, value);
>> +     }
>> +
>> +     reg_wr(&icap->icap_regs->ir_cr, 0x1);
>> +
>> +     for (i = 0; i < 20; i++) {
>> +             value = reg_rd(&icap->icap_regs->ir_cr);
>> +             if ((value & 0x1) == 0)
>> +                     return 0;
>> +             ndelay(50);
>> +     }
>> +
>> +     ICAP_ERR(icap, "writing %d dwords timeout", size);
>> +     return -EIO;
>> +}
>> +
>> +static int bitstream_helper(struct icap *icap, const u32 *word_buffer,
>> +                         u32 word_count)
>> +{
>> +     u32 remain_word;
>> +     u32 word_written = 0;
>> +     int wr_fifo_vacancy = 0;
>> +     int err = 0;
>> +
>> +     WARN_ON(!mutex_is_locked(&icap->icap_lock));
>> +     for (remain_word = word_count; remain_word > 0;
>> +             remain_word -= word_written, word_buffer += word_written) {
>> +             wr_fifo_vacancy = reg_rd(&icap->icap_regs->ir_wfv);
>> +             if (wr_fifo_vacancy <= 0) {
>> +                     ICAP_ERR(icap, "no vacancy: %d", wr_fifo_vacancy);
>> +                     err = -EIO;
>> +                     break;
>> +             }
>> +             word_written = (wr_fifo_vacancy < remain_word) ?
>> +                     wr_fifo_vacancy : remain_word;
>> +             if (icap_write(icap, word_buffer, word_written) != 0) {
>> +                     ICAP_ERR(icap, "write failed remain %d, written %d",
>> +                              remain_word, word_written);
>> +                     err = -EIO;
>> +                     break;
>> +             }
>> +     }
>> +
>> +     return err;
>> +}
>> +
>> +static int icap_download(struct icap *icap, const char *buffer,
>> +                      unsigned long length)
>> +{
>> +     u32     num_chars_read = DMA_HWICAP_BITFILE_BUFFER_SIZE;
>> +     u32     byte_read;
>> +     int     err = 0;
>> +
>> +     mutex_lock(&icap->icap_lock);
>> +     for (byte_read = 0; byte_read < length; byte_read += num_chars_read) {
>> +             num_chars_read = length - byte_read;
>> +             if (num_chars_read > DMA_HWICAP_BITFILE_BUFFER_SIZE)
>> +                     num_chars_read = DMA_HWICAP_BITFILE_BUFFER_SIZE;
>> +
>> +             err = bitstream_helper(icap, (u32 *)buffer, num_chars_read / sizeof(u32));
> assumption that num_chars_read % 4 == 0
>
> Add a check, or handle.
Sure.
>
>> +             if (err)
>> +                     goto failed;
>> +             buffer += num_chars_read;
>> +     }
>> +
>> +     err = wait_for_done(icap);
> timeout is not handled
>> +
>> +failed:
>> +     mutex_unlock(&icap->icap_lock);
>> +
>> +     return err;
>> +}
>> +
>> +/*
>> + * Run the following sequence of canned commands to obtain IDCODE of the FPGA
>> + */
>> +static void icap_probe_chip(struct icap *icap)
>> +{
>> +     u32 w;
> De magic this.
>
> If this is a documented startup sequence, please add a link to the document.
>
> Else add a comment about what you are doing here.
>
> Where possible, convert the hex values to #defines.
Will add comment for this.

Thanks,
Lizhi
>
> Tom
>
>> +
>> +     w = reg_rd(&icap->icap_regs->ir_sr);
>> +     w = reg_rd(&icap->icap_regs->ir_sr);
>> +     reg_wr(&icap->icap_regs->ir_gier, 0x0);
>> +     w = reg_rd(&icap->icap_regs->ir_wfv);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0xffffffff);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0xaa995566);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0x28018001);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
>> +     reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     reg_wr(&icap->icap_regs->ir_cr, 0x1);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     w = reg_rd(&icap->icap_regs->ir_sr);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     w = reg_rd(&icap->icap_regs->ir_sr);
>> +     reg_wr(&icap->icap_regs->ir_sz, 0x1);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     reg_wr(&icap->icap_regs->ir_cr, 0x2);
>> +     w = reg_rd(&icap->icap_regs->ir_rfo);
>> +     icap->idcode = reg_rd(&icap->icap_regs->ir_rf);
>> +     w = reg_rd(&icap->icap_regs->ir_cr);
>> +     (void)w;
>> +}
>> +
>> +static int
>> +xrt_icap_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
>> +{
>> +     struct xrt_icap_ioctl_wr        *wr_arg = arg;
>> +     struct icap                     *icap;
>> +     int                             ret = 0;
>> +
>> +     icap = platform_get_drvdata(pdev);
>> +
>> +     switch (cmd) {
>> +     case XRT_XLEAF_EVENT:
>> +             /* Does not handle any event. */
>> +             break;
>> +     case XRT_ICAP_WRITE:
>> +             ret = icap_download(icap, wr_arg->xiiw_bit_data,
>> +                                 wr_arg->xiiw_data_len);
>> +             break;
>> +     case XRT_ICAP_IDCODE:
>> +             *(u64 *)arg = icap->idcode;
>> +             break;
>> +     default:
>> +             ICAP_ERR(icap, "unknown command %d", cmd);
>> +             return -EINVAL;
>> +     }
>> +
>> +     return ret;
>> +}
>> +
>> +static int xrt_icap_remove(struct platform_device *pdev)
>> +{
>> +     struct icap     *icap;
>> +
>> +     icap = platform_get_drvdata(pdev);
>> +
>> +     platform_set_drvdata(pdev, NULL);
>> +     devm_kfree(&pdev->dev, icap);
>> +
>> +     return 0;
>> +}
>> +
>> +static int xrt_icap_probe(struct platform_device *pdev)
>> +{
>> +     struct icap     *icap;
>> +     int                     ret = 0;
>> +     struct resource         *res;
>> +
>> +     icap = devm_kzalloc(&pdev->dev, sizeof(*icap), GFP_KERNEL);
>> +     if (!icap)
>> +             return -ENOMEM;
>> +
>> +     icap->pdev = pdev;
>> +     platform_set_drvdata(pdev, icap);
>> +     mutex_init(&icap->icap_lock);
>> +
>> +     xrt_info(pdev, "probing");
>> +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +     if (res) {
>> +             icap->icap_regs = ioremap(res->start, res->end - res->start + 1);
>> +             if (!icap->icap_regs) {
>> +                     xrt_err(pdev, "map base failed %pR", res);
>> +                     ret = -EIO;
>> +                     goto failed;
>> +             }
>> +     }
>> +
>> +     icap_probe_chip(icap);
>> +failed:
>> +     return ret;
>> +}
>> +
>> +static struct xrt_subdev_endpoints xrt_icap_endpoints[] = {
>> +     {
>> +             .xse_names = (struct xrt_subdev_ep_names[]) {
>> +                     { .ep_name = XRT_MD_NODE_FPGA_CONFIG },
>> +                     { NULL },
>> +             },
>> +             .xse_min_ep = 1,
>> +     },
>> +     { 0 },
>> +};
>> +
>> +static struct xrt_subdev_drvdata xrt_icap_data = {
>> +     .xsd_dev_ops = {
>> +             .xsd_ioctl = xrt_icap_leaf_ioctl,
>> +     },
>> +};
>> +
>> +static const struct platform_device_id xrt_icap_table[] = {
>> +     { XRT_ICAP, (kernel_ulong_t)&xrt_icap_data },
>> +     { },
>> +};
>> +
>> +static struct platform_driver xrt_icap_driver = {
>> +     .driver = {
>> +             .name = XRT_ICAP,
>> +     },
>> +     .probe = xrt_icap_probe,
>> +     .remove = xrt_icap_remove,
>> +     .id_table = xrt_icap_table,
>> +};
>> +
>> +void icap_leaf_init_fini(bool init)
>> +{
>> +     if (init)
>> +             xleaf_register_driver(XRT_SUBDEV_ICAP, &xrt_icap_driver, xrt_icap_endpoints);
>> +     else
>> +             xleaf_unregister_driver(XRT_SUBDEV_ICAP);
>> +}

