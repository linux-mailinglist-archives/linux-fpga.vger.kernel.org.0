Return-Path: <linux-fpga+bounces-1325-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACC4B2B433
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Aug 2025 00:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09BD25822D0
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Aug 2025 22:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8C21EC01D;
	Mon, 18 Aug 2025 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="BfLBizKU";
	dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b="PpBtkIQp"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtpx1.feld.cvut.cz (smtpx1.feld.cvut.cz [147.32.210.191])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF63451B8;
	Mon, 18 Aug 2025 22:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.32.210.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557266; cv=none; b=Xoat4Ev1H6GckNKCS1nltj5EPXV0u49nkzr3IR+opWoVrbKcLE3CKEf1dq2YsLdo6zXk7uT/I8Vj53JnOIE23OZroSOTXvYpBwwasP5UhwvB/F90FAkhhdUqe+bLmmlILmRi9p/QE6iRgrjMApdM0Ku4OOYFmxO/149+1vAp9hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557266; c=relaxed/simple;
	bh=oO+k1HXNeS3ehoLNDTjn9tfx8LCsIFJP0H5et/Hgkps=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:MIME-Version:
	 Content-Type:Content-Disposition:Message-Id; b=Z4cSlceRxI/cwGlKdfKVmP3BcXYxI3yk2xJ6vVwJnN52bGsjgVhTD8zyE0KT30QgMJQGwToza3vuGxE6gSvexYSsAFavk6d4vZ67gfiYiRB+ToMT1JbnX0sdhphTTE9F/J8EmJgwRNNMoNV089/1NN68xT9DEke8n4dVB6w/ZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz; spf=pass smtp.mailfrom=fel.cvut.cz; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=BfLBizKU; dkim=pass (2048-bit key) header.d=fel.cvut.cz header.i=@fel.cvut.cz header.b=PpBtkIQp; arc=none smtp.client-ip=147.32.210.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fel.cvut.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fel.cvut.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1755556744;
	bh=vYtxQk1cPIG1fXCrw1Yv/ml3QK7/3ZZ2KBsmFe60blo=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=BfLBizKUQEaV4ctJQkXPPoWNNF1y3MVHd10UI/9Yj31nU+e/YcwdqYMllD9aMIeQ3
	 kapNVgTvhqA7J+TEVOsEYVP4wspwSHFMhd+4uEH1LbERNYyXIUynikpeKCzlqdhAUv
	 OdrmCm7TxoqKvIymgOGT732C7AagvIxrl38EIAeFr2MCYJX+S9JwW4M+U44h3gzAG2
	 X8U58gFpwkB8wUoCt/yi6UiwvTtq6L9H5WL910eX2bH1snFJxAAO5k0EFVwAiUZoiv
	 hZTPpY3yy3O9K6QaxfOqLQRVlx3o8bBjg4Rt32r715hYyWvZ+H38T3vIAf8lSfMd7u
	 WNzk70h1O0kFg==
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtpx1.feld.cvut.cz (Postfix) with ESMTPS id C1C532C320;
	Tue, 19 Aug 2025 00:39:04 +0200 (CEST)
Received: from localhost (unknown [192.168.200.27])
	by smtpx.fel.cvut.cz (Postfix) with ESMTP id B8ABA2C23D;
	Tue, 19 Aug 2025 00:39:04 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id YRB0MpK6HyIs; Tue, 19 Aug 2025 00:39:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
	s=felmail; t=1755556743;
	bh=vYtxQk1cPIG1fXCrw1Yv/ml3QK7/3ZZ2KBsmFe60blo=;
	h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
	b=PpBtkIQpbwTiKkH3u2OD0nIBwsJik+Y7LcR08OSCvSy+C9hVn/Sa2jSfdVIPqXhdW
	 hkTC+t/E5+dZFtiImNa1i6cruRthbEQeava42nRAcQkRSFr+d/PFh8uFsNj8762JpB
	 s9cJEwPDi881AUKgByL+wnYPoFsDjanZllJN1kB0Cxf5nv1m8tZkPfrOL5sLLblwbs
	 SmVwupWm8hZVOM+OpSvcXO8n7qF5B1QoyOsypjHf3EQ7ciyonXVfyCh9sbmVLNPZWE
	 /Bxi7c+R9yJBXl8gZbxDARP3RBh0LE7tCuBORIjZ3mAymAzMSHmhDHu28/MZraNsZA
	 CSxd/gJcoPzHA==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz [84.242.78.234])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pisa)
	by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 26FB92C23C;
	Tue, 19 Aug 2025 00:38:59 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/1] fpga: zynq_fpga: Fix the wrong usage of dma_map_sgtable()
Date: Tue, 19 Aug 2025 00:39:02 +0200
User-Agent: KMail/1.9.10
Cc: Xu Yilun <yilun.xu@linux.intel.com>,
 jgg@nvidia.com,
 m.szyprowski@samsung.com,
 yilun.xu@intel.com,
 linux-fpga@vger.kernel.org,
 mdf@kernel.org,
 linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@amd.com>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>
References: <20250806070605.1920909-1-yilun.xu@linux.intel.com> <20250806070605.1920909-2-yilun.xu@linux.intel.com>
In-Reply-To: <20250806070605.1920909-2-yilun.xu@linux.intel.com>
X-KMail-QuotePrefix: > 
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202508190039.02454.pisa@fel.cvut.cz>

Hello Greg and others,

please, is there some progress/decision about the fix for mainline?

Our daily test of mainline Linux kernel build and test of CAN
communication latency on Zynq system with loaded CTU CAN FD
IP core ends with unresponsive kernel. The last successful
mainline build is from July 29
 
  run-250729-042256-hist+6.16.0-g283564a43383+oaat-kern.json
  https://canbus.pages.fel.cvut.cz/can-latester/

I have analyzed the cause and reported (August 4) that mainline
Zynq runtime FPGA bitstream loading was broken by patch

  37e00703228a ("zynq_fpga: use sgtable-based scatterlist wrappers")

Xu Yilun and others from the FPGA community reacted promptly
with the fix on August 6. The fix has propagated into linux-next.
Is there a plan to accept it for the 6.17 version, or would it be
accepted only for 6.18?

If it is expected that it takes a longer time, or even 6.17
would be released with non-functional Zynq FPGA manager support
then we need to add patching of the broken kernel into our system
because we do not want to lose months of kernel state monitoring
and testing, because more problems could slip in during that time.
We have already caught some problems with the RT variant in the past
thanks to our effort and we have reported quickly even actual
case still during 6.17 merge window. The current breakage
in the mainline test fails our whole series, and we are losing even
RT assessment without changes prepared for the long-term mainline
fails, which is exceptional in our three-year testing effort.

Best wishes,

Pavel


On Wednesday 06 of August 2025 09:06:05 Xu Yilun wrote:
> dma_map_sgtable() returns only 0 or the error code. Read sgt->nents to
> get the number of mapped segments.
>
> CC: stable@vger.kernel.org
> Fixes: 37e00703228a ("zynq_fpga: use sgtable-based scatterlist wrappers")
> Reported-by: Pavel Pisa <pisa@fel.cvut.cz>
> Closes:
> https://lore.kernel.org/linux-fpga/202508041548.22955.pisa@fel.cvut.cz/
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Tested-by: Pavel Pisa <pisa@fel.cvut.cz>
> ---
>  drivers/fpga/zynq-fpga.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index 0be0d569589d..b7629a0e4813 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -405,12 +405,12 @@ static int zynq_fpga_ops_write(struct fpga_manager
> *mgr, struct sg_table *sgt) }
>  	}
>
> -	priv->dma_nelms =
> -	    dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
> -	if (priv->dma_nelms == 0) {
> +	err = dma_map_sgtable(mgr->dev.parent, sgt, DMA_TO_DEVICE, 0);
> +	if (err) {
>  		dev_err(&mgr->dev, "Unable to DMA map (TO_DEVICE)\n");
> -		return -ENOMEM;
> +		return err;
>  	}
> +	priv->dma_nelms = sgt->nents;
>
>  	/* enable clock */
>  	err = clk_enable(priv->clk);


-- 
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

