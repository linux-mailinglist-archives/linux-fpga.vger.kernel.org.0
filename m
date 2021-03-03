Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 795B432BDC2
	for <lists+linux-fpga@lfdr.de>; Wed,  3 Mar 2021 23:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhCCQa5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 3 Mar 2021 11:30:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245172AbhCCPOE (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 3 Mar 2021 10:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614784349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qHfNfuVrMiks47LKaqZBsrIcwN1DGBx0YYA80i206FI=;
        b=Rs4HSmGA7IQInVZ9l6n+p2WgP7Yr6XpDrdhv12tQbG7YLcDr+3gryo2xk+FHCXW2SomjpV
        15zLJvS9/Op5zJ70wGZVTbFpoj+nzQxqI7Zi9hoRn4ujIostA8C6ZpyOFtbCX1sxr/fUrf
        RowT7IG6kmA6Db3iJBWCiER2zTIJmT4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-seBShf5cMYuzaJNcDDC9DQ-1; Wed, 03 Mar 2021 10:12:28 -0500
X-MC-Unique: seBShf5cMYuzaJNcDDC9DQ-1
Received: by mail-qv1-f72.google.com with SMTP id dz17so8996894qvb.14
        for <linux-fpga@vger.kernel.org>; Wed, 03 Mar 2021 07:12:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=qHfNfuVrMiks47LKaqZBsrIcwN1DGBx0YYA80i206FI=;
        b=LUaDkBxyTkgMaQjuGianI3WWrQh67XZ6674MFSWlohr/p0mrrTEcpn2w5oJdkkroM3
         znhq4GXy+WwQtTGild7Rp/Ks3YXTPWimWgKDThRbfGBqYQUgFewATVjErYneYpwqhWNd
         RVUujJnIQ4orDjXGHGDP2CmFuNirJIbAisdjUXy4Q8HKS4n611z9trwBD1rWD++JDvgt
         OgGPKA3Ccsnael8xvT5lML+kFi5qooeFzwims7zeQnAdd30gIMrELhKcU9xFj0yENWru
         EqZsOIFa57mFJ+mUqXA87LfHdxnj+NcFQtkxhSWwEaGLYC3e43iHwEx4EvmP75B9qMHr
         QJpA==
X-Gm-Message-State: AOAM530+4mO/onLXeRsNG0LtJ7btjC7yVLapwDtaGKX4GZTVL887L6sO
        QwzkLW4AX4UsiGaONmL6b240lZ8OyAqhUARBBFMGedo/jOrzs3z1f7gaoO9333Qr8UagSAg3b1n
        2KCxogZKRl17PafhcZvffuQ==
X-Received: by 2002:ac8:35d1:: with SMTP id l17mr23147404qtb.127.1614784347788;
        Wed, 03 Mar 2021 07:12:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNQOZ02X2nA4fBhCsZNWwA2J3yIWw5iu8ogSW+HfrOhzLheBYD196oAyHXABmXPMY8TcFNYQ==
X-Received: by 2002:ac8:35d1:: with SMTP id l17mr23147238qtb.127.1614784345750;
        Wed, 03 Mar 2021 07:12:25 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q15sm15547232qti.9.2021.03.03.07.12.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Mar 2021 07:12:25 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 12/18] fpga: xrt: ICAP platform driver
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-13-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <6bbcff78-cd3b-fad8-157f-f11dc30cad21@redhat.com>
Date:   Wed, 3 Mar 2021 07:12:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-13-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 2/17/21 10:40 PM, Lizhi Hou wrote:
> Add ICAP driver. ICAP is a hardware function discovered by walking
What does ICAP stand for ?
> firmware metadata. A platform device node will be created for it.
> FPGA bitstream is written to hardware through ICAP.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  drivers/fpga/xrt/include/xleaf/icap.h |  29 +++
>  drivers/fpga/xrt/lib/xleaf/icap.c     | 317 ++++++++++++++++++++++++++
>  2 files changed, 346 insertions(+)
>  create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>
> diff --git a/drivers/fpga/xrt/include/xleaf/icap.h b/drivers/fpga/xrt/include/xleaf/icap.h
> new file mode 100644
> index 000000000000..a14fc0ffa78f
> --- /dev/null
> +++ b/drivers/fpga/xrt/include/xleaf/icap.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Header file for XRT ICAP Leaf Driver
> + *
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
> + * ICAP driver IOCTL calls.
> + */
> +enum xrt_icap_ioctl_cmd {
> +	XRT_ICAP_WRITE = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
maybe XRT_ICAP_GET_IDCODE
> +	XRT_ICAP_IDCODE,
> +};
> +
> +struct xrt_icap_ioctl_wr {
> +	void	*xiiw_bit_data;
> +	u32	xiiw_data_len;
> +};
> +
> +#endif	/* _XRT_ICAP_H_ */
> diff --git a/drivers/fpga/xrt/lib/xleaf/icap.c b/drivers/fpga/xrt/lib/xleaf/icap.c
> new file mode 100644
> index 000000000000..0500a97bdef9
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/xleaf/icap.c
> @@ -0,0 +1,317 @@
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
> + * AXI-HWICAP IP register layout
> + */
> +struct icap_reg {
> +	u32	ir_rsvd1[7];
> +	u32	ir_gier;
> +	u32	ir_isr;
> +	u32	ir_rsvd2;
> +	u32	ir_ier;
> +	u32	ir_rsvd3[53];
> +	u32	ir_wf;
> +	u32	ir_rf;
> +	u32	ir_sz;
> +	u32	ir_cr;
> +	u32	ir_sr;
> +	u32	ir_wfv;
> +	u32	ir_rfo;
> +	u32	ir_asr;
> +} __packed;
> +
> +struct icap {
> +	struct platform_device	*pdev;
> +	struct icap_reg		*icap_regs;
> +	struct mutex		icap_lock; /* icap dev lock */
> +
> +	unsigned int		idcode;
returned as a 64 bit value, but could be stored as 32 bit
> +};
> +
> +static inline u32 reg_rd(void __iomem *reg)
> +{
> +	if (!reg)
> +		return -1;
> +
> +	return ioread32(reg);
Look at converting the io access to using regmap* api
> +}
> +
> +static inline void reg_wr(void __iomem *reg, u32 val)
> +{
> +	if (!reg)
> +		return;
> +
> +	iowrite32(val, reg);
> +}
> +
> +static int wait_for_done(struct icap *icap)
> +{
> +	u32	w;
> +	int	i = 0;
> +
> +	WARN_ON(!mutex_is_locked(&icap->icap_lock));
is this needed ? wait_for_done is only called in one place.
> +	for (i = 0; i < 10; i++) {
> +		udelay(5);
comment on delay.
> +		w = reg_rd(&icap->icap_regs->ir_sr);
> +		ICAP_INFO(icap, "XHWICAP_SR: %x", w);
> +		if (w & 0x5)
0x5 is a magic number, should be #defined
> +			return 0;
> +	}
> +
> +	ICAP_ERR(icap, "bitstream download timeout");
> +	return -ETIMEDOUT;
> +}
> +
> +static int icap_write(struct icap *icap, const u32 *word_buf, int size)
> +{
> +	int i;
> +	u32 value = 0;
> +
> +	for (i = 0; i < size; i++) {
> +		value = be32_to_cpu(word_buf[i]);
> +		reg_wr(&icap->icap_regs->ir_wf, value);
> +	}
> +
> +	reg_wr(&icap->icap_regs->ir_cr, 0x1);
> +
> +	for (i = 0; i < 20; i++) {
> +		value = reg_rd(&icap->icap_regs->ir_cr);
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
> +	u32 remain_word;
> +	u32 word_written = 0;
> +	int wr_fifo_vacancy = 0;
> +	int err = 0;
> +
> +	WARN_ON(!mutex_is_locked(&icap->icap_lock));
> +	for (remain_word = word_count; remain_word > 0;
> +		remain_word -= word_written, word_buffer += word_written) {
> +		wr_fifo_vacancy = reg_rd(&icap->icap_regs->ir_wfv);
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
> +	u32	num_chars_read = DMA_HWICAP_BITFILE_BUFFER_SIZE;
> +	u32	byte_read;
> +	int	err = 0;
> +
> +	mutex_lock(&icap->icap_lock);
> +	for (byte_read = 0; byte_read < length; byte_read += num_chars_read) {
> +		num_chars_read = length - byte_read;
> +		if (num_chars_read > DMA_HWICAP_BITFILE_BUFFER_SIZE)
> +			num_chars_read = DMA_HWICAP_BITFILE_BUFFER_SIZE;
> +
> +		err = bitstream_helper(icap, (u32 *)buffer, num_chars_read / sizeof(u32));

assumption that num_chars_read % 4 == 0

Add a check, or handle.

> +		if (err)
> +			goto failed;
> +		buffer += num_chars_read;
> +	}
> +
> +	err = wait_for_done(icap);
timeout is not handled
> +
> +failed:
> +	mutex_unlock(&icap->icap_lock);
> +
> +	return err;
> +}
> +
> +/*
> + * Run the following sequence of canned commands to obtain IDCODE of the FPGA
> + */
> +static void icap_probe_chip(struct icap *icap)
> +{
> +	u32 w;

De magic this.

If this is a documented startup sequence, please add a link to the document.

Else add a comment about what you are doing here.

Where possible, convert the hex values to #defines.

Tom

> +
> +	w = reg_rd(&icap->icap_regs->ir_sr);
> +	w = reg_rd(&icap->icap_regs->ir_sr);
> +	reg_wr(&icap->icap_regs->ir_gier, 0x0);
> +	w = reg_rd(&icap->icap_regs->ir_wfv);
> +	reg_wr(&icap->icap_regs->ir_wf, 0xffffffff);
> +	reg_wr(&icap->icap_regs->ir_wf, 0xaa995566);
> +	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
> +	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
> +	reg_wr(&icap->icap_regs->ir_wf, 0x28018001);
> +	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
> +	reg_wr(&icap->icap_regs->ir_wf, 0x20000000);
> +	w = reg_rd(&icap->icap_regs->ir_cr);
> +	reg_wr(&icap->icap_regs->ir_cr, 0x1);
> +	w = reg_rd(&icap->icap_regs->ir_cr);
> +	w = reg_rd(&icap->icap_regs->ir_cr);
> +	w = reg_rd(&icap->icap_regs->ir_sr);
> +	w = reg_rd(&icap->icap_regs->ir_cr);
> +	w = reg_rd(&icap->icap_regs->ir_sr);
> +	reg_wr(&icap->icap_regs->ir_sz, 0x1);
> +	w = reg_rd(&icap->icap_regs->ir_cr);
> +	reg_wr(&icap->icap_regs->ir_cr, 0x2);
> +	w = reg_rd(&icap->icap_regs->ir_rfo);
> +	icap->idcode = reg_rd(&icap->icap_regs->ir_rf);
> +	w = reg_rd(&icap->icap_regs->ir_cr);
> +	(void)w;
> +}
> +
> +static int
> +xrt_icap_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
> +{
> +	struct xrt_icap_ioctl_wr	*wr_arg = arg;
> +	struct icap			*icap;
> +	int				ret = 0;
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
> +	case XRT_ICAP_IDCODE:
> +		*(u64 *)arg = icap->idcode;
> +		break;
> +	default:
> +		ICAP_ERR(icap, "unknown command %d", cmd);
> +		return -EINVAL;
> +	}
> +
> +	return ret;
> +}
> +
> +static int xrt_icap_remove(struct platform_device *pdev)
> +{
> +	struct icap	*icap;
> +
> +	icap = platform_get_drvdata(pdev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	devm_kfree(&pdev->dev, icap);
> +
> +	return 0;
> +}
> +
> +static int xrt_icap_probe(struct platform_device *pdev)
> +{
> +	struct icap	*icap;
> +	int			ret = 0;
> +	struct resource		*res;
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
> +	if (res) {
> +		icap->icap_regs = ioremap(res->start, res->end - res->start + 1);
> +		if (!icap->icap_regs) {
> +			xrt_err(pdev, "map base failed %pR", res);
> +			ret = -EIO;
> +			goto failed;
> +		}
> +	}
> +
> +	icap_probe_chip(icap);
> +failed:
> +	return ret;
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
> +		.xsd_ioctl = xrt_icap_leaf_ioctl,
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
> +	.remove = xrt_icap_remove,
> +	.id_table = xrt_icap_table,
> +};
> +
> +void icap_leaf_init_fini(bool init)
> +{
> +	if (init)
> +		xleaf_register_driver(XRT_SUBDEV_ICAP, &xrt_icap_driver, xrt_icap_endpoints);
> +	else
> +		xleaf_unregister_driver(XRT_SUBDEV_ICAP);
> +}

