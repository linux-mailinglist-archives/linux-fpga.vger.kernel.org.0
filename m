Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22D2372B9E
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 16:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhEDOG7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 10:06:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54328 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231361AbhEDOG7 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 May 2021 10:06:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620137164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6PsIOR6MunyPEkI628H9q3RPxX3AK2AUBCabv843mzM=;
        b=eFkz+ertxwxmuiMjiy6PqYm5zR0ZPkMhHbBSXtb35GNZB0T6xdbJ0o8kiR7BeekPOFnMfc
        X4lbZo5K2LwVsuz2BM2sue6kB6eWrX62KoXhAdSeUl/9ONyHRlL3mCryOkZxUhxHu8Lpd0
        D7x0Io8qfql1zb5fuZcTYKiVcsZM2oY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-pkLCSSzjNPOV_aojza0Exg-1; Tue, 04 May 2021 10:06:01 -0400
X-MC-Unique: pkLCSSzjNPOV_aojza0Exg-1
Received: by mail-qv1-f71.google.com with SMTP id y18-20020a0cd9920000b02901c32e3e18f7so7652385qvj.15
        for <linux-fpga@vger.kernel.org>; Tue, 04 May 2021 07:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=6PsIOR6MunyPEkI628H9q3RPxX3AK2AUBCabv843mzM=;
        b=NavErS8MxgDrl630+TXHKvRQ54CJURinJEyPuq8zDN9gbgb3m3RX41Dr673TgPGp8k
         s0lVE81RZmqjLDvB7RyYAy+nT2ctDjpq5BVpRtnZUBaU9XAP9J+FOaG6w/JqjmmIbpT+
         u+jU0oI/3glIwEkIPbAMo5v8v+Fpx6ziGZ7I+OkJ7wK3wF/2qBn+he+Z3Crv8e1xn1rm
         GEJkPCJt3/d+sa5bk3BkBqeZLXyevUsDCPHyqukNJqMhs8cK92JHfWKMQmKb8yRSygM7
         oEqSQ9rX/sioA2HmLqsGynHlxG5KnPPsU4G9y+w575T00QyZdXhAoRFNuONrODjfqpuv
         r3QA==
X-Gm-Message-State: AOAM5322QFzjrNalvY1Ovsgpkhs5ziU6KghrgITmTwV+P1Juun5ESmJF
        aZoSE51mLqpycRSx2XEbpKVNG/1wcsZ+nORuFAqFimgJAfBfRwjH3HJMJpHQOJ43EdIXHLljO/h
        Iha39769ONRkNFc5w1CcA4Q==
X-Received: by 2002:a37:2e81:: with SMTP id u123mr25468340qkh.218.1620137160638;
        Tue, 04 May 2021 07:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJytI9pfxEnaDLC16AeA+wUl9yYqnoHGZFKlo5K79wlPSv6jWNaxv5YwruRjCKIS8jbvRDOJpg==
X-Received: by 2002:a37:2e81:: with SMTP id u123mr25468305qkh.218.1620137160347;
        Tue, 04 May 2021 07:06:00 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 7sm2742277qtu.38.2021.05.04.07.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:05:59 -0700 (PDT)
Subject: Re: [PATCH V5 XRT Alveo 14/20] fpga: xrt: ICAP driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
 <20210427205431.23896-15-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <72c17e54-db67-aa1c-162c-5a33f4b865ee@redhat.com>
Date:   Tue, 4 May 2021 07:05:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427205431.23896-15-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/27/21 1:54 PM, Lizhi Hou wrote:
> ICAP stands for Hardware Internal Configuration Access Port. ICAP is
> discovered by walking the firmware metadata. A xrt device node will be
> created for it. FPGA bitstream is written to hardware through ICAP.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   drivers/fpga/xrt/include/xleaf/icap.h |  27 +++
>   drivers/fpga/xrt/lib/xleaf/icap.c     | 328 ++++++++++++++++++++++++++
>   2 files changed, 355 insertions(+)
>   create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/icap.h b/drivers/fpga/xrt/include/xleaf/icap.h
> new file mode 100644
> index 000000000000..96d39a8934fa
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/icap.h
> @@ -0,0 +1,27 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *	Lizhi Hou <Lizhi.Hou@xilinx.com>
> + */
> +
> +#ifndef _XRT_ICAP_H_
> +#define _XRT_ICAP_H_
> +
> +#include "xleaf.h"
> +
> +/*
> + * ICAP driver leaf calls.
> + */
> +enum xrt_icap_leaf_cmd {
> +	XRT_ICAP_WRITE = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
> +	XRT_ICAP_GET_IDCODE,
> +};
> +
> +struct xrt_icap_wr {
> +	void	*xiiw_bit_data;
> +	u32	xiiw_data_len;
> +};
> +
> +#endif	/* _XRT_ICAP_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/icap.c b/drivers/fpga/xrt/lib/xleaf/icap.c
> new file mode 100644
> index 000000000000..755ea2fc0e75
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/icap.c
> @@ -0,0 +1,328 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo FPGA ICAP Driver
> + *
> + * Copyright (C) 2020-2021 Xilinx, Inc.
> + *
> + * Authors:
> + *      Lizhi Hou<Lizhi.Hou@xilinx.com>
> + *      Sonal Santan <sonals@xilinx.com>
> + *      Max Zhen <maxz@xilinx.com>
> + */
> +
> +#include <linux/mod_devicetable.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/regmap.h>
> +#include <linux/io.h>
> +#include "metadata.h"
> +#include "xleaf.h"
> +#include "xleaf/icap.h"
> +#include "xclbin-helper.h"
> +
> +#define XRT_ICAP "xrt_icap"
> +
> +#define ICAP_ERR(icap, fmt, arg...)	\
> +	xrt_err((icap)->xdev, fmt "\n", ##arg)
> +#define ICAP_WARN(icap, fmt, arg...)	\
> +	xrt_warn((icap)->xdev, fmt "\n", ##arg)
> +#define ICAP_INFO(icap, fmt, arg...)	\
> +	xrt_info((icap)->xdev, fmt "\n", ##arg)
> +#define ICAP_DBG(icap, fmt, arg...)	\
> +	xrt_dbg((icap)->xdev, fmt "\n", ##arg)
> +
> +/*
> + * AXI-HWICAP IP register layout. Please see
> + * https://www.xilinx.com/support/documentation/ip_documentation/axi_hwicap/v3_0/pg134-axi-hwicap.pdf
> + */
> +#define ICAP_REG_GIER		0x1C
> +#define ICAP_REG_ISR		0x20
> +#define ICAP_REG_IER		0x28
> +#define ICAP_REG_WF		0x100
> +#define ICAP_REG_RF		0x104
> +#define ICAP_REG_SZ		0x108
> +#define ICAP_REG_CR		0x10C
> +#define ICAP_REG_SR		0x110
> +#define ICAP_REG_WFV		0x114
> +#define ICAP_REG_RFO		0x118
> +#define ICAP_REG_ASR		0x11C
> +
> +#define ICAP_STATUS_EOS		0x4
> +#define ICAP_STATUS_DONE	0x1
> +
> +/*
> + * Canned command sequence to obtain IDCODE of the FPGA
> + */
> +static const u32 idcode_stream[] = {
> +	/* dummy word */
> +	cpu_to_be32(0xffffffff),
> +	/* sync word */
> +	cpu_to_be32(0xaa995566),
> +	/* NOP word */
> +	cpu_to_be32(0x20000000),
> +	/* NOP word */
> +	cpu_to_be32(0x20000000),
> +	/* ID code */
> +	cpu_to_be32(0x28018001),
> +	/* NOP word */
> +	cpu_to_be32(0x20000000),
> +	/* NOP word */
> +	cpu_to_be32(0x20000000),
> +};
> +
> +XRT_DEFINE_REGMAP_CONFIG(icap_regmap_config);
> +
> +struct icap {
> +	struct xrt_device	*xdev;
> +	struct regmap		*regmap;
> +	struct mutex		icap_lock; /* icap dev lock */

ok

Reviwed-by: Tom Rix <trix@redhat.com>

> +	u32			idcode;
> +};
> +
> +static int wait_for_done(const struct icap *icap)
> +{
> +	int i = 0;
> +	int ret;
> +	u32 w;
> +
> +	for (i = 0; i < 10; i++) {
> +		/*
> +		 * it requires few micro seconds for ICAP to process incoming data.
> +		 * Polling every 5us for 10 times would be good enough.
> +		 */
> +		udelay(5);
> +		ret = regmap_read(icap->regmap, ICAP_REG_SR, &w);
> +		if (ret)
> +			return ret;
> +		ICAP_INFO(icap, "XHWICAP_SR: %x", w);
> +		if (w & (ICAP_STATUS_EOS | ICAP_STATUS_DONE))
> +			return 0;
> +	}
> +
> +	ICAP_ERR(icap, "bitstream download timeout");
> +	return -ETIMEDOUT;
> +}
> +
> +static int icap_write(const struct icap *icap, const u32 *word_buf, int size)
> +{
> +	u32 value = 0;
> +	int ret;
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +		value = be32_to_cpu(word_buf[i]);
> +		ret = regmap_write(icap->regmap, ICAP_REG_WF, value);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_write(icap->regmap, ICAP_REG_CR, 0x1);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < 20; i++) {
> +		ret = regmap_read(icap->regmap, ICAP_REG_CR, &value);
> +		if (ret)
> +			return ret;
> +
> +		if ((value & 0x1) == 0)
> +			return 0;
> +		ndelay(50);
> +	}
> +
> +	ICAP_ERR(icap, "writing %d dwords timeout", size);
> +	return -EIO;
> +}
> +
> +static int bitstream_helper(struct icap *icap, const u32 *word_buffer,
> +			    u32 word_count)
> +{
> +	int wr_fifo_vacancy = 0;
> +	u32 word_written = 0;
> +	u32 remain_word;
> +	int err = 0;
> +
> +	WARN_ON(!mutex_is_locked(&icap->icap_lock));
> +	for (remain_word = word_count; remain_word > 0;
> +	     remain_word -= word_written, word_buffer += word_written) {
> +		err = regmap_read(icap->regmap, ICAP_REG_WFV, &wr_fifo_vacancy);
> +		if (err) {
> +			ICAP_ERR(icap, "read wr_fifo_vacancy failed %d", err);
> +			break;
> +		}
> +		if (wr_fifo_vacancy <= 0) {
> +			ICAP_ERR(icap, "no vacancy: %d", wr_fifo_vacancy);
> +			err = -EIO;
> +			break;
> +		}
> +		word_written = (wr_fifo_vacancy < remain_word) ?
> +			wr_fifo_vacancy : remain_word;
> +		if (icap_write(icap, word_buffer, word_written) != 0) {
> +			ICAP_ERR(icap, "write failed remain %d, written %d",
> +				 remain_word, word_written);
> +			err = -EIO;
> +			break;
> +		}
> +	}
> +
> +	return err;
> +}
> +
> +static int icap_download(struct icap *icap, const char *buffer,
> +			 unsigned long length)
> +{
> +	u32	num_chars_read = XCLBIN_HWICAP_BITFILE_BUF_SZ;
> +	u32	byte_read;
> +	int	err = 0;
> +
> +	if (length % sizeof(u32)) {
> +		ICAP_ERR(icap, "invalid bitstream length %ld", length);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&icap->icap_lock);
> +	for (byte_read = 0; byte_read < length; byte_read += num_chars_read) {
> +		num_chars_read = length - byte_read;
> +		if (num_chars_read > XCLBIN_HWICAP_BITFILE_BUF_SZ)
> +			num_chars_read = XCLBIN_HWICAP_BITFILE_BUF_SZ;
> +
> +		err = bitstream_helper(icap, (u32 *)buffer, num_chars_read / sizeof(u32));
> +		if (err)
> +			goto failed;
> +		buffer += num_chars_read;
> +	}
> +
> +	/* there is not any cleanup needs to be done if writing ICAP timeout. */
> +	err = wait_for_done(icap);
> +
> +failed:
> +	mutex_unlock(&icap->icap_lock);
> +
> +	return err;
> +}
> +
> +/*
> + * Discover the FPGA IDCODE using special sequence of canned commands
> + */
> +static int icap_probe_chip(struct icap *icap)
> +{
> +	int err;
> +	u32 val = 0;
> +
> +	regmap_read(icap->regmap, ICAP_REG_SR, &val);
> +	if (val != ICAP_STATUS_DONE)
> +		return -ENODEV;
> +	/* Read ICAP FIFO vacancy */
> +	regmap_read(icap->regmap, ICAP_REG_WFV, &val);
> +	if (val < 8)
> +		return -ENODEV;
> +	err = icap_write(icap, idcode_stream, ARRAY_SIZE(idcode_stream));
> +	if (err)
> +		return err;
> +	err = wait_for_done(icap);
> +	if (err)
> +		return err;
> +
> +	/* Tell config engine how many words to transfer to read FIFO */
> +	regmap_write(icap->regmap, ICAP_REG_SZ, 0x1);
> +	/* Switch the ICAP to read mode */
> +	regmap_write(icap->regmap, ICAP_REG_CR, 0x2);
> +	err = wait_for_done(icap);
> +	if (err)
> +		return err;
> +
> +	/* Read IDCODE from Read FIFO */
> +	regmap_read(icap->regmap, ICAP_REG_RF, &icap->idcode);
> +	return 0;
> +}
> +
> +static int
> +xrt_icap_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
> +{
> +	struct xrt_icap_wr *wr_arg = arg;
> +	struct icap *icap;
> +	int ret = 0;
> +
> +	icap = xrt_get_drvdata(xdev);
> +
> +	switch (cmd) {
> +	case XRT_XLEAF_EVENT:
> +		/* Does not handle any event. */
> +		break;
> +	case XRT_ICAP_WRITE:
> +		ret = icap_download(icap, wr_arg->xiiw_bit_data,
> +				    wr_arg->xiiw_data_len);
> +		break;
> +	case XRT_ICAP_GET_IDCODE:
> +		*(u32 *)arg = icap->idcode;
> +		break;
> +	default:
> +		ICAP_ERR(icap, "unknown command %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int xrt_icap_probe(struct xrt_device *xdev)
> +{
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +	struct icap *icap;
> +	int result = 0;
> +
> +	icap = devm_kzalloc(&xdev->dev, sizeof(*icap), GFP_KERNEL);
> +	if (!icap)
> +		return -ENOMEM;
> +
> +	icap->xdev = xdev;
> +	xrt_set_drvdata(xdev, icap);
> +	mutex_init(&icap->icap_lock);
> +
> +	xrt_info(xdev, "probing");
> +	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	base = devm_ioremap_resource(&xdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	icap->regmap = devm_regmap_init_mmio(&xdev->dev, base, &icap_regmap_config);
> +	if (IS_ERR(icap->regmap)) {
> +		ICAP_ERR(icap, "init mmio failed");
> +		return PTR_ERR(icap->regmap);
> +	}
> +	/* Disable ICAP interrupts */
> +	regmap_write(icap->regmap, ICAP_REG_GIER, 0);
> +
> +	result = icap_probe_chip(icap);
> +	if (result)
> +		xrt_err(xdev, "Failed to probe FPGA");
> +	else
> +		xrt_info(xdev, "Discovered FPGA IDCODE %x", icap->idcode);
> +	return result;
> +}
> +
> +static struct xrt_dev_endpoints xrt_icap_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_dev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_FPGA_CONFIG },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_driver xrt_icap_driver = {
> +	.driver = {
> +		.name = XRT_ICAP,
> +	},
> +	.subdev_id = XRT_SUBDEV_ICAP,
> +	.endpoints = xrt_icap_endpoints,
> +	.probe = xrt_icap_probe,
> +	.leaf_call = xrt_icap_leaf_call,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(icap);

