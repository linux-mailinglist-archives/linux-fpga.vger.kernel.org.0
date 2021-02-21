Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F20320D93
	for <lists+linux-fpga@lfdr.de>; Sun, 21 Feb 2021 21:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBUUZf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 21 Feb 2021 15:25:35 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:39826 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbhBUUZe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 21 Feb 2021 15:25:34 -0500
Received: by mail-pj1-f50.google.com with SMTP id d2so7443379pjs.4;
        Sun, 21 Feb 2021 12:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e3EF98HcHqv63rz737CQqm7GCGbFsRovjAbHCUjj+vo=;
        b=GGOJwQl/mZfihO9V3FeEmsq/UAg4mPoeBXWudaO3OVBBq1Aajw3p/73morz+xuuqqp
         PhqirMlqJmSRnvdrLlBjKf9m3Bhic3GXfxYuAnMve7TQ4+KjIi/OeoERB5Yoczp6WQGn
         Xo7TUiSndpQBRNZIyFcl5mK2BP7yMCPpMVVhL5qZ56ffj+JlzpVCj2TPX3Pg+GqvTab8
         c6l5Cm2VZzjJ+48MwI5IDLYyK6dCbinM0rkQmH85o7rA/FAHJDhugDrp4zh4FJAN/M30
         vUBK4QJH6EkfG3sKnpEmKgFs7s7V9fjXKv9xzT2aemAVomC5qVPoNX2vvG9+rWkyqq9e
         cx2Q==
X-Gm-Message-State: AOAM531FIo2OLqDGKcZz0lkZKWBk8fNuIYdMKrY9UcAhn9W/6K9BmP5c
        cd8xDSxqm5kCl+GiIzOMgjE=
X-Google-Smtp-Source: ABdhPJzcwsITB1uTOT9oUVAJ78q2QzQjDmuGODUaAaNJz6RneH4tq35lfVRqL+jee/3p82enZzCODA==
X-Received: by 2002:a17:90a:4092:: with SMTP id l18mr19917740pjg.39.1613939093439;
        Sun, 21 Feb 2021 12:24:53 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id g6sm16422638pfi.15.2021.02.21.12.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 12:24:52 -0800 (PST)
Date:   Sun, 21 Feb 2021 12:24:55 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, Lizhi Hou <lizhih@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com,
        mdf@kernel.org, robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V3 XRT Alveo 12/18] fpga: xrt: ICAP platform driver
Message-ID: <YDLBl2GFjSVcxCUe@archbook>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-13-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218064019.29189-13-lizhih@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Wed, Feb 17, 2021 at 10:40:13PM -0800, Lizhi Hou wrote:
> Add ICAP driver. ICAP is a hardware function discovered by walking
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

Do we really need two layers of indirection here? What's wrong with
dev_{info,dbg,...} ?
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

Can we make those #define and just use writel/readl() ? If you want more
abstraction, use regmap....
> +
> +struct icap {
> +	struct platform_device	*pdev;
> +	struct icap_reg		*icap_regs;
> +	struct mutex		icap_lock; /* icap dev lock */
> +
> +	unsigned int		idcode;
> +};
> +
> +static inline u32 reg_rd(void __iomem *reg)
> +{
> +	if (!reg)
> +		return -1;
> +
> +	return ioread32(reg);
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
> +	for (i = 0; i < 10; i++) {
> +		udelay(5);
> +		w = reg_rd(&icap->icap_regs->ir_sr);
> +		ICAP_INFO(icap, "XHWICAP_SR: %x", w);
> +		if (w & 0x5)
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
> +		if (err)
> +			goto failed;
> +		buffer += num_chars_read;
> +	}
> +
> +	err = wait_for_done(icap);
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
?!
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
> -- 
> 2.18.4
> 
- Moritz
