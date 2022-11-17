Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F050062DE67
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Nov 2022 15:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbiKQOiA (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Nov 2022 09:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbiKQOha (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Nov 2022 09:37:30 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87A865865;
        Thu, 17 Nov 2022 06:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668695743; x=1700231743;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=R+irvtrU5pEWAqUyJ3WlJnw9AP3Lq6dpD3UwnZjoXpw=;
  b=O+VhskxVla5KEaGUDhnjGx5Y0YoJPSKpQdSrA0gYqkvDg1cIijqEHHv1
   JEKIhTsZDuivhIGY6ccWXcOL6yU2m6OJcrFIB9MDo00x5gYVThKfoCDlh
   6Z/7QGsNrnjA0v5LQuSzhi+9H2txCSFfPUM2x8xzH5hs3amVq1sIi2ikT
   lZZWz4W6BqTW7bJHsnrOmhgwnZAfPmGsDB5npznSp0l8MU4mN1GDv+MDp
   r/WbLCfA/yA/bd++S8cn5Z4TjTcww0/M5tTQ+aeuAkp5VNP7dHTRfuR+a
   MNr6og+tvT9WzsP+Ynca6cY1uBNV2ryDQ3W4boft1ZR8EQnKkF+/nIJqY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="296227776"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="296227776"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 06:35:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10534"; a="703353319"
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="703353319"
Received: from kvehmane-mobl1.ger.corp.intel.com ([10.252.61.113])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2022 06:35:26 -0800
Date:   Thu, 17 Nov 2022 16:35:23 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] regmap: indirect: Add indirect regmap support
In-Reply-To: <Y3Y4vWr/CGbaH0HQ@sirena.org.uk>
Message-ID: <a089f1a0-c0f4-e1a2-d084-fd83e28e7e33@linux.intel.com>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com> <20221117120515.37807-8-ilpo.jarvinen@linux.intel.com> <Y3Y4vWr/CGbaH0HQ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-857486337-1668695730=:1636"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-857486337-1668695730=:1636
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Thu, 17 Nov 2022, Mark Brown wrote:

> On Thu, Nov 17, 2022 at 02:05:11PM +0200, Ilpo Järvinen wrote:
> > Add support for indirect register access via a regmap interface.
> > 
> > Indirect register access is a generic way to access registers indirectly.
> > One use case is accessing registers on Intel FPGA IPs with e.g. PMCI or
> > HSSI.
> 
> I can't tell from this changelog what exactly you're trying to
> implement here...
>
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Indirect Register Access.
> > + *
> > + * Copyright (C) 2020-2022 Intel Corporation, Inc.
> > + */
> > +#include <linux/debugfs.h>
> 
> Please make the entire comment a C++ one so things look more
> intentional.

Eh, all/most SPDX-License-Identifier lines are done like this one?!?

> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/seq_file.h>
> 
> I can't see what seq_file.h is used for, which is probably good
> TBH since the interfaces it offers don't look like things I'd
> expect a regmap bus to use.

Yeah, it seems it was not even the only useless header. I'll clean 
them up.

> > +static int indirect_bus_reg_read(void *context, unsigned int reg,
> > +				     unsigned int *val)
> > +{
> > +	struct indirect_ctx *ctx = context;
> > +	unsigned int cmd, ack, tmpval;
> > +	int ret;
> > +
> > +	cmd = readl(ctx->base + ctx->indirect_cfg->cmd_offset);
> > +	if (cmd != ctx->indirect_cfg->idle_cmd)
> > +		dev_warn(ctx->dev, "residual cmd 0x%x on read entry\n", cmd);
> > +
> > +	writel(reg, ctx->base + ctx->indirect_cfg->addr_offset);
> > +	writel(ctx->indirect_cfg->read_cmd, ctx->base + ctx->indirect_cfg->cmd_offset);
> > +
> > +	ret = readl_poll_timeout(ctx->base + ctx->indirect_cfg->ack_offset, ack,
> > +				 (ack & ctx->indirect_cfg->ack_mask) == ctx->indirect_cfg->ack_mask,
> > +				 ctx->indirect_cfg->sleep_us, ctx->indirect_cfg->timeout_us);
> 
> This all looks very specific to one particular implementation,
> requiring a particular set of memory mapped registers and
> operations - things like the initial read of the command for
> example. It's not clear to me how much reuse this is likely to
> see outside of the one driver you're trying to add - if you want
> to implement something device specific you can just provide
> the custom operations in the device's regmap configuration rather
> than having to provide a bus.  Why add a bus?

The point of not doing it in a particular driver is that the users will 
be spread around more than into a single driver. This is a generic 
mechanism for accessing registers of IPs on Intel FPGA. The point being 
that IPs can use this common mechanism rather than each coming up their 
own way.

Mark Brown objected earlier naming it something related to Intel FPGAs [1]
but I certainly know it still fixes the operations like you note even if 
the offsets and values are now "customizable" (they weren't in the 
earliest versions of this patch).

[1] https://lore.kernel.org/all/YqB9O8HhZV2tXo8g@sirena.org.uk/T/#m75d4abdfd00f05866d837246ddc357a8af53cf99

-- 
 i.

--8323329-857486337-1668695730=:1636--
