Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6429E3555B6
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244243AbhDFNut (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 09:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30686 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238092AbhDFNus (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Apr 2021 09:50:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617717040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg7MZeMyO05OLe8WY/MWvjkatYFZ0OXBdmW1J6v6yDg=;
        b=dyLm+k5LxH8iZO2jkmFZ3+aCbEj2XPS9PWsKXDERNImvBJoZr8oZS676N8vHxeYec8at5o
        UIFVgKwplf1ayJJ6l1j83udzJVlrFMebgBnOJIO9UfWBgfk+eDIlJyIqjuF9Lnsi01VFg8
        cGIvMd9sNNN4ZocWXyiG6AxF3jysOEA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-N7OwvHuUMRCWBOVVdLq7nw-1; Tue, 06 Apr 2021 09:50:36 -0400
X-MC-Unique: N7OwvHuUMRCWBOVVdLq7nw-1
Received: by mail-qv1-f71.google.com with SMTP id ek16so1474734qvb.3
        for <linux-fpga@vger.kernel.org>; Tue, 06 Apr 2021 06:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fg7MZeMyO05OLe8WY/MWvjkatYFZ0OXBdmW1J6v6yDg=;
        b=X7u7lP85BoHa1ZzhnPMWh36mF78JvRbR9I0gmCAsVrXcLVBKyFdmm3aUQeuT2gOQ42
         5EAZxEUu7y2E5I+mHuCZi1MaiVbVt8loi24K1f11yeZhay10opzLcLAyygS85eUXmiza
         NtfdEPbF5i8xPOZ4qlAZTrRWb4s21RdUhXFXjrD9/PSf0y77LpMcfrqqG2GzjVNna5gy
         F3TiusWT5BwFJLWYxk53U1/wUVTk1O+tYHkwZfhMmS2CinGclr5/metIuWHt8hwzL/+x
         TnvCSgio7h2K99zLM+dOMAGFz/L/MYwaChy1QFjAVKglSv5TMk4hcqQxo5dlr2DpAB1I
         Y2DQ==
X-Gm-Message-State: AOAM531lYkKzvnPu+nfDx92A1f4F2A12yUdYRUryL0LGS47abCjIgii8
        iOaHyFgDDrJTsQe03CtxH4LV/FkbJVqT7xKRhuAiDCLsA6/cNsf177uwqz0qeITUJIGyfshlLPe
        Z3Gj1EYUwJnhIPteSNoVjEQ==
X-Received: by 2002:ac8:a4c:: with SMTP id f12mr28257963qti.329.1617717036114;
        Tue, 06 Apr 2021 06:50:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwh7w1EXFTzZxsrG8pZN3dZ4EWmVucXWzozuTk2yQKMSyVgUUErsMuyBULUkiWA1j0avpy6rA==
X-Received: by 2002:ac8:a4c:: with SMTP id f12mr28257944qti.329.1617717035837;
        Tue, 06 Apr 2021 06:50:35 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o125sm15756762qkf.87.2021.04.06.06.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 06:50:35 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 14/20] fpga: xrt: ICAP platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-15-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <cff70244-5eb7-7620-da08-2324f3ba26d7@redhat.com>
Date:   Tue, 6 Apr 2021 06:50:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-15-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/23/21 10:29 PM, Lizhi Hou wrote:
> ICAP stands for Hardware Internal Configuration Access Port. ICAP is
> discovered by walking firmware metadata. A platform device node will be
by walking the firmware
> created for it. FPGA bitstream is written to hardware through ICAP.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   drivers/fpga/xrt/include/xleaf/icap.h |  27 ++
>   drivers/fpga/xrt/lib/xleaf/icap.c     | 344 ++++++++++++++++++++++++++
>   2 files changed, 371 insertions(+)
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
ok
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
> index 000000000000..13db2b759138
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/icap.c
> @@ -0,0 +1,344 @@
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
> +#include <linux/platform_device.h>
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
> +	xrt_err((icap)->pdev, fmt "\n", ##arg)
> +#define ICAP_WARN(icap, fmt, arg...)	\
> +	xrt_warn((icap)->pdev, fmt "\n", ##arg)
> +#define ICAP_INFO(icap, fmt, arg...)	\
> +	xrt_info((icap)->pdev, fmt "\n", ##arg)
> +#define ICAP_DBG(icap, fmt, arg...)	\
> +	xrt_dbg((icap)->pdev, fmt "\n", ##arg)
> +
> +/*
> + * AXI-HWICAP IP register layout. Please see
> + * https://www.xilinx.com/support/documentation/ip_documentation/axi_hwicap/v3_0/pg134-axi-hwicap.pdf
url works, looks good
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
> +static const struct regmap_config icap_regmap_config = {
ok
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x1000,
> +};
> +
> +struct icap {
> +	struct platform_device	*pdev;
> +	struct regmap		*regmap;
> +	struct mutex		icap_lock; /* icap dev lock */
> +
whitespace, remove extra nl
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
ok
> +		 */
> +		udelay(5);
> +		ret = regmap_read(icap->regmap, ICAP_REG_SR, &w);
> +		if (ret)
> +			return ret;
> +		ICAP_INFO(icap, "XHWICAP_SR: %x", w);
> +		if (w & (ICAP_STATUS_EOS | ICAP_STATUS_DONE))
ok
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
ok
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

ok, thanks for demagic-ing this function.

Looks good overall, only a few minor things.

Reviewed-by: Tom Rix <trix@redhat.com>

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
> +xrt_icap_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	struct xrt_icap_wr *wr_arg = arg;
> +	struct icap *icap;
> +	int ret = 0;
> +
> +	icap = platform_get_drvdata(pdev);
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
> +static int xrt_icap_probe(struct platform_device *pdev)
> +{
> +	void __iomem *base = NULL;
> +	struct resource *res;
> +	struct icap *icap;
> +	int result = 0;
> +
> +	icap = devm_kzalloc(&pdev->dev, sizeof(*icap), GFP_KERNEL);
> +	if (!icap)
> +		return -ENOMEM;
> +
> +	icap->pdev = pdev;
> +	platform_set_drvdata(pdev, icap);
> +	mutex_init(&icap->icap_lock);
> +
> +	xrt_info(pdev, "probing");
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	icap->regmap = devm_regmap_init_mmio(&pdev->dev, base, &icap_regmap_config);
> +	if (IS_ERR(icap->regmap)) {
> +		ICAP_ERR(icap, "init mmio failed");
> +		return PTR_ERR(icap->regmap);
> +	}
> +	/* Disable ICAP interrupts */
> +	regmap_write(icap->regmap, ICAP_REG_GIER, 0);
> +
> +	result = icap_probe_chip(icap);
> +	if (result)
> +		xrt_err(pdev, "Failed to probe FPGA");
> +	else
> +		xrt_info(pdev, "Discovered FPGA IDCODE %x", icap->idcode);
> +	return result;
> +}
> +
> +static struct xrt_subdev_endpoints xrt_icap_endpoints[] = {
> +	{
> +		.xse_names = (struct xrt_subdev_ep_names[]) {
> +			{ .ep_name = XRT_MD_NODE_FPGA_CONFIG },
> +			{ NULL },
> +		},
> +		.xse_min_ep = 1,
> +	},
> +	{ 0 },
> +};
> +
> +static struct xrt_subdev_drvdata xrt_icap_data = {
> +	.xsd_dev_ops = {
> +		.xsd_leaf_call = xrt_icap_leaf_call,
> +	},
> +};
> +
> +static const struct platform_device_id xrt_icap_table[] = {
> +	{ XRT_ICAP, (kernel_ulong_t)&xrt_icap_data },
> +	{ },
> +};
> +
> +static struct platform_driver xrt_icap_driver = {
> +	.driver = {
> +		.name = XRT_ICAP,
> +	},
> +	.probe = xrt_icap_probe,
> +	.id_table = xrt_icap_table,
> +};
> +
> +XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_ICAP, icap);

