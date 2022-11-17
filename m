Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7E062DCEB
	for <lists+linux-fpga@lfdr.de>; Thu, 17 Nov 2022 14:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234901AbiKQNgD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 17 Nov 2022 08:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234893AbiKQNgC (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 17 Nov 2022 08:36:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E11373428;
        Thu, 17 Nov 2022 05:36:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E692161E18;
        Thu, 17 Nov 2022 13:36:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA920C433D6;
        Thu, 17 Nov 2022 13:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668692161;
        bh=K2PdyXue1T1mB/kQrqHZQRjeefIBFNaF0sLD9ShBKWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYlAqzB1OTHwETApwkMwZk4pY5rKcO3R/AdOeGSZMK4xDdPJSU9tUZOqtsAof9xMx
         9EElW5NudHGjgiyV6YdWOA0LEJRBObSFN5L6hQ6NaTrD75DYkVAV+cpvGsWCHdsS41
         Uny7dtY9zPK3VDZq/FOCjDYN74mPR511cOfIG+6nHaDTyCG1l9fnCS2j/Wo8txuwnZ
         hVMwH2yzJ3vLUeqzRfRKYzt4U48VqjJaZQuGXWcfeDAvoLtUgAIiogN1fI9usUcdGO
         ydyLH20OWdtWMMDHZ0O0fSMTtOXkL+eR2coAjxgwkLCa9xlzjIZV3BeQ/mA7L1rTa7
         rNA+N5VMf0IOg==
Date:   Thu, 17 Nov 2022 13:35:57 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-fpga@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Lee Jones <lee@kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Marco Pagani <marpagan@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/11] regmap: indirect: Add indirect regmap support
Message-ID: <Y3Y4vWr/CGbaH0HQ@sirena.org.uk>
References: <20221117120515.37807-1-ilpo.jarvinen@linux.intel.com>
 <20221117120515.37807-8-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nQO9GaPF0umGSqdg"
Content-Disposition: inline
In-Reply-To: <20221117120515.37807-8-ilpo.jarvinen@linux.intel.com>
X-Cookie: Ego sum ens omnipotens.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--nQO9GaPF0umGSqdg
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2022 at 02:05:11PM +0200, Ilpo J=E4rvinen wrote:
> Add support for indirect register access via a regmap interface.
>=20
> Indirect register access is a generic way to access registers indirectly.
> One use case is accessing registers on Intel FPGA IPs with e.g. PMCI or
> HSSI.

I can't tell from this changelog what exactly you're trying to
implement here...

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Indirect Register Access.
> + *
> + * Copyright (C) 2020-2022 Intel Corporation, Inc.
> + */
> +#include <linux/debugfs.h>

Please make the entire comment a C++ one so things look more
intentional.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/seq_file.h>

I can't see what seq_file.h is used for, which is probably good
TBH since the interfaces it offers don't look like things I'd
expect a regmap bus to use.

> +static int indirect_bus_reg_read(void *context, unsigned int reg,
> +				     unsigned int *val)
> +{
> +	struct indirect_ctx *ctx =3D context;
> +	unsigned int cmd, ack, tmpval;
> +	int ret;
> +
> +	cmd =3D readl(ctx->base + ctx->indirect_cfg->cmd_offset);
> +	if (cmd !=3D ctx->indirect_cfg->idle_cmd)
> +		dev_warn(ctx->dev, "residual cmd 0x%x on read entry\n", cmd);
> +
> +	writel(reg, ctx->base + ctx->indirect_cfg->addr_offset);
> +	writel(ctx->indirect_cfg->read_cmd, ctx->base + ctx->indirect_cfg->cmd_=
offset);
> +
> +	ret =3D readl_poll_timeout(ctx->base + ctx->indirect_cfg->ack_offset, a=
ck,
> +				 (ack & ctx->indirect_cfg->ack_mask) =3D=3D ctx->indirect_cfg->ack_m=
ask,
> +				 ctx->indirect_cfg->sleep_us, ctx->indirect_cfg->timeout_us);

This all looks very specific to one particular implementation,
requiring a particular set of memory mapped registers and
operations - things like the initial read of the command for
example.  It's not clear to me how much reuse this is likely to
see outside of the one driver you're trying to add - if you want
to implement something device specific you can just provide
the custom operations in the device's regmap configuration rather
than having to provide a bus.  Why add a bus?

--nQO9GaPF0umGSqdg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmN2OLwACgkQJNaLcl1U
h9D5ZAf/e5fz0cFGzhXEImFM0J/nvy+stqG9TBm5URXEa3SpNg7qjqiRjbNAjhI3
+7c06CM8HurjZy3klhWEo7/JUGd5v2v32CUWN9W3dEnuQ+M3CB7xT3QiFusJWFbd
nskK15BqEAEHf3R8PvjdBLYA15iuERAasqkmu7RizSGUASprR8kL98DoMokT70Ss
y2wld1jFZ/aptfe5HsAuD6wwS9w0oB8M9D00sHpxIJXmaM+Zc8AFvHq+U98Z20ee
N6SpI82D53BpeJ+WjgfrcjrQ3BTmS31yQsfhmJnv5qjsyqbgK37A9JRI1HQK7157
sQEZKenH4YfdmGOYe2YMSrM2isDUkg==
=OsB+
-----END PGP SIGNATURE-----

--nQO9GaPF0umGSqdg--
