Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D7A74CB61
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Jul 2023 06:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjGJEpt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 10 Jul 2023 00:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGJEps (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 10 Jul 2023 00:45:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED19D118;
        Sun,  9 Jul 2023 21:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688964347; x=1720500347;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H8FsJEDpdcP+jyEgEwdZYjOOerdTEzQ5/CpOqwU86vU=;
  b=WONv7AnP4xl1MleoayhOwD8Pc8RVhQwYkyxpDfRz5+0NUQuCEJTjclMm
   rf6zOUTOx2U1I9lT6qq3xKke+Vb7H7ARuPtA2N5m/4a8UP1xIqYJgutRy
   cO0puJ+BkkqDm3dvPP33Ov0sngoaKTPSr2hyXO/N48+5d0reTuf+r6sNV
   SeIkPEdWpYq9SbKy7+pI5SbUdT73Et+VwqD2dt6cJUhaq//DHDikjKTk/
   xBTpvaaieWKeLW+z4FWPUgdA6SjJm1dLPcJHrZwwtJFBLzPEn8riUFpVF
   hJEjosZfwJ2xA0hgMgN4fmhEsJqH8vMj7VfEKiIGSqITlob1F2GkqOBQ9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="364292281"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="364292281"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2023 21:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="720568357"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="720568357"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orsmga002.jf.intel.com with ESMTP; 09 Jul 2023 21:45:45 -0700
Date:   Mon, 10 Jul 2023 12:44:18 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Marco Pagani <marpagan@redhat.com>
Cc:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v8 1/4] fpga: add an initial KUnit suite for the FPGA
 Manager
Message-ID: <ZKuMosEu242BrY0K@yilunxu-OptiPlex-7050>
References: <20230630152507.30219-1-marpagan@redhat.com>
 <20230630152507.30219-2-marpagan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630152507.30219-2-marpagan@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 2023-06-30 at 17:25:04 +0200, Marco Pagani wrote:
> The suite tests the basic behaviors of the FPGA Manager including
> programming using a single contiguous buffer and a scatter gather table.
> 
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---
>  drivers/fpga/tests/fpga-mgr-test.c | 311 +++++++++++++++++++++++++++++
>  1 file changed, 311 insertions(+)
>  create mode 100644 drivers/fpga/tests/fpga-mgr-test.c
> 
> diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
> new file mode 100644
> index 000000000000..6fd2e235f195
> --- /dev/null
> +++ b/drivers/fpga/tests/fpga-mgr-test.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit test for the FPGA Manager
> + *
> + * Copyright (C) 2023 Red Hat, Inc.
> + *
> + * Author: Marco Pagani <marpagan@redhat.com>
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/device.h>
> +#include <linux/fpga/fpga-mgr.h>
> +#include <linux/module.h>
> +#include <linux/scatterlist.h>
> +#include <linux/types.h>
> +
> +#define HEADER_FILL		'H'
> +#define IMAGE_FILL		'P'
> +#define IMAGE_BLOCK		1024
> +
> +#define HEADER_SIZE		IMAGE_BLOCK
> +#define IMAGE_SIZE		(IMAGE_BLOCK * 4)
> +
> +struct mgr_stats {
> +	bool header_match;
> +	bool image_match;
> +	u32 seq_num;
> +	u32 op_parse_header_seq;
> +	u32 op_write_init_seq;
> +	u32 op_write_seq;
> +	u32 op_write_sg_seq;
> +	u32 op_write_complete_seq;
> +	enum fpga_mgr_states op_parse_header_state;
> +	enum fpga_mgr_states op_write_init_state;
> +	enum fpga_mgr_states op_write_state;
> +	enum fpga_mgr_states op_write_sg_state;
> +	enum fpga_mgr_states op_write_complete_state;
> +};
> +
> +struct mgr_ctx {
> +	struct fpga_image_info *img_info;
> +	struct fpga_manager *mgr;
> +	struct platform_device *pdev;
> +	struct mgr_stats stats;
> +};
> +
> +/**
> + * init_test_buffer() - Allocate and initialize a test image in a buffer.
> + * @test: KUnit test context object.
> + * @count: image size in bytes.
> + *
> + * Return: pointer to the newly allocated image.
> + */
> +static char *init_test_buffer(struct kunit *test, size_t count)
> +{
> +	char *buf;
> +
> +	KUNIT_ASSERT_GE(test, count, HEADER_SIZE);
> +
> +	buf = kunit_kzalloc(test, count, GFP_KERNEL);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buf);
> +
> +	memset(buf, HEADER_FILL, HEADER_SIZE);
> +	memset(buf + HEADER_SIZE, IMAGE_FILL, count - HEADER_SIZE);
> +
> +	return buf;
> +}
> +
> +static int op_parse_header(struct fpga_manager *mgr, struct fpga_image_info *info,
> +			   const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +	size_t i;
> +
> +	/* Set header_size and data_size for later */
> +	info->header_size = HEADER_SIZE;
> +	info->data_size = info->count - HEADER_SIZE;
> +
> +	stats->header_match = true;
> +
> +	/* Check header */
> +	for (i = 0; i < info->header_size; i++)
> +		if (buf[i] != HEADER_FILL)
> +			stats->header_match = false;
> +
> +	stats->op_parse_header_state = mgr->state;
> +	stats->op_parse_header_seq = stats->seq_num++;
> +
> +	return 0;
> +}
> +
> +static int op_write_init(struct fpga_manager *mgr, struct fpga_image_info *info,
> +			 const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +
> +	stats->op_write_init_state = mgr->state;
> +	stats->op_write_init_seq = stats->seq_num++;
> +
> +	return 0;
> +}
> +
> +static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +	size_t i;
> +
> +	/* Check the image */
> +	stats->image_match = true;
> +	for (i = 0; i < count; i++)
> +		if (buf[i] != IMAGE_FILL)
> +			stats->image_match = false;
> +
> +	stats->op_write_state = mgr->state;
> +	stats->op_write_seq = stats->seq_num++;
> +
> +	return 0;
> +}
> +
> +static int op_write_sg(struct fpga_manager *mgr, struct sg_table *sgt)
> +{
> +	struct mgr_stats *stats = mgr->priv;
> +	struct sg_mapping_iter miter;
> +	char *img;
> +	size_t i;
> +
> +	/*
> +	 * Check the image, but first skip the header since write_sg will get
> +	 * the whole image in sg_table.
> +	 */
> +	stats->image_match = true;
> +	sg_miter_start(&miter, sgt->sgl, sgt->nents, SG_MITER_FROM_SG);
> +
> +	if (!sg_miter_skip(&miter, HEADER_SIZE))
> +		stats->image_match = false;

If this fails, should we continue?

> +
> +	while (sg_miter_next(&miter)) {
> +		img = miter.addr;
> +		for (i = 0; i < miter.length; i++) {
> +			if (img[i] != IMAGE_FILL)
> +				stats->image_match = false;
> +		}
> +	}
> +
> +	sg_miter_stop(&miter);
> +
> +	stats->op_write_sg_state = mgr->state;
> +	stats->op_write_sg_seq = stats->seq_num++;
> +
> +	return 0;
> +}
