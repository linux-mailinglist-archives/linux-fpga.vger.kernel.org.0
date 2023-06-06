Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D62572415F
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Jun 2023 13:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbjFFL4G (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Jun 2023 07:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjFFL4F (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Jun 2023 07:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F36E186;
        Tue,  6 Jun 2023 04:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFF3C63148;
        Tue,  6 Jun 2023 11:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F7FC433D2;
        Tue,  6 Jun 2023 11:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686052564;
        bh=uBJEZTUv5RvXsGAg/te3x8cXEikFuFG5WWm4+OY5LHQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRQVA0+iJmXuPi/uDwgA/uALIsfJcH38Uepk4sWigJXKDmd6DLajM0mO8kyjgOJJS
         T5pq2gGlLOSDySpc8sN1bNhh0j8G/kDvHk1BP46nnTuHasUYuFuoV9tybm0g+n6X7X
         ClqprtV97SGJ3rKYKTycL8GhX9N0o52bHD2VnVxxTwIyaqb+fMa6MMCmQYzqNyO+BO
         lu0q7l1NCBAuO6JFTWPua38fBjXzarFx/1yiRcfrYgcUr+MLC9XZCI2sUxfpqJ8HMB
         gSH5njhRcu/R5VKdOi8+MjqVRAexLS330SZo3CJMAcNzObYE+vFGChYW+i+McZUV+t
         JLkADmMhLFaVw==
Date:   Tue, 6 Jun 2023 12:55:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-spi@vger.kernel.org, linux-fpga@vger.kernel.org,
        conor@kernel.org, Vladimir Georgiev <v.georgiev@metrotek.ru>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        valentina.fernandezalanis@microchip.com
Subject: Re: [BUG] microchip-spi programming issue
Message-ID: <e0b6908a-7f13-425d-8f5a-e9e90a54a2c1@sirena.org.uk>
References: <20230606-reentry-undusted-3c44fd7b4325@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oXpUzd6RTIauBLlY"
Content-Disposition: inline
In-Reply-To: <20230606-reentry-undusted-3c44fd7b4325@wendy>
X-Cookie: Keep out of the sunlight.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


--oXpUzd6RTIauBLlY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 06, 2023 at 12:30:02PM +0100, Conor Dooley wrote:

> Following on from that, how strong is "normally" in the comment above?
> Is it valid for a controller to deassert CS even if cs_change is not
> set? Or have I totally misunderstood things and there's something
> invalid about how the transfers are being set up in the driver?

It is obviously going to corrupt the transfer if we deassert chip select
without being asked, it is only valid to change it during a message if
cs_change is set.

--oXpUzd6RTIauBLlY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmR/Hs0ACgkQJNaLcl1U
h9B2wgf+P5jqFjdq/DX1AzTo4WloyXPlFB1hUO/dD3LE+aJRzFLPI5wCmduT0y+s
FoR3uY2WU3n963MCsFAuSv+ncCbXzYmmXSaAjxwjt7CDDCD+slum4kNfmE3nFj5r
Me4TA8jo7K2V+qMc5Ttb8jJmkPE/Ut87O0D9DLtUTM5PlXchYEWhVTmtdd9IzFiW
HeCNEGylxsEl6yGF5sZuyhEk+EZmaLHMlylS6W8dGTnRM6j8IwLgtpt2NIjsRO2m
a6nSiUlcRbN6X5qzpRI+tYwDDVO98buT5ExzOHjGQmTsqMWxHTijt8oVgaMzMTtg
MkvQFduNDM7j0BPBOlPav4U0FXeJPg==
=8NVM
-----END PGP SIGNATURE-----

--oXpUzd6RTIauBLlY--
