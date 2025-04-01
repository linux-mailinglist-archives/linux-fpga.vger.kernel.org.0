Return-Path: <linux-fpga+bounces-1133-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACD8A77467
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Apr 2025 08:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2AF8168B5F
	for <lists+linux-fpga@lfdr.de>; Tue,  1 Apr 2025 06:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0F61DED52;
	Tue,  1 Apr 2025 06:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqsPBV6Z"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1297131E2D;
	Tue,  1 Apr 2025 06:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743488280; cv=none; b=DCn+kKuLVXOPFuyzUWCl85uRiZQR6KvsdPAgHoCR/PFzeK6EO5/7FkYPZCk04OeD89wfUoJBFnnd4P1PkBt2E5wQ7b++SqRDHy6iusqeLQaMPaP8hq5jjrY6eCrb8cNyBK+VRjh6yUsIjgA620+XqtwK2eftd/55MTsUxJfFjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743488280; c=relaxed/simple;
	bh=KnEDjwzU7f+yS42V6ce7fa3bnnh/T4X0uQ0vYcQujSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgrWC1l2Z0cGC9oOqVSF7j+PYrb75cnN+0FbWPuciuKnmtwaEyGKGxLoSmfaGeZigL/UjI3oBw2C2mlgok6t6/WYGbJ6guBrsy7vjDaBN69pJ8LTsOseOrImWTuMtgK2KtNZq74ztEjc2/M+Lv4abfV+gWcEJzRVXWKGluu2Lcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqsPBV6Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA6BC4CEE8;
	Tue,  1 Apr 2025 06:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743488279;
	bh=KnEDjwzU7f+yS42V6ce7fa3bnnh/T4X0uQ0vYcQujSU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqsPBV6ZDjA4JXFCcrEZ63438y/20vB2mvHM3E8CAfefaN/roeihqcnBpj4gL6fHt
	 9/T50ZfHic0p24x1YYnVJa663OpTSmjaHIHVvXiOG5tv/Z4dTOqC0zeFQ6ZNA0+iPe
	 7FWOerDBjRrtbWN9DbBZ79Bco+tjFDaYU0nJvmtwZAvmKCsUCd33QelYSFp3YDvgs7
	 1ew6Ye5Q9HFLThkniDCATefPUbhcE7ZL5m5/pUFrBmJ3XU0UFZ75F+j9IzrZcqbYDl
	 p4vhmBOM+SRRGSWXMfdL/391h1gCMGdZs977xO0b9bABOUcT4WVbaWzyjjUS8nk7Vl
	 WHhhcegmHDJ3w==
Date: Tue, 1 Apr 2025 08:17:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sam Winchenbach <sam.winchenbach@framepointer.org>
Cc: linux-kernel@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com, 
	yilun.xu@intel.com, trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, michal.simek@amd.com, linux-fpga@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Sam Winchenbach <swinchenbach@arka.org>
Subject: Re: [PATCH 1/2] dt-bindings: fpga: zynq: Document ICAP on boot
Message-ID: <20250401-helpful-bronze-gazelle-4d8e25@krzk-bin>
References: <20250328141944.119504-1-sam.winchenbach@framepointer.org>
 <02496a88-3d9c-49ee-93ab-8f1400fc0c6b@kernel.org>
 <p4bujnmgkcvsu4qipmgh2j2loedepmwgp7zlaxrurhaveb6tbc@ibqtbjnbzdzj>
 <14b12882-119d-4c24-9634-e4cc37a39212@kernel.org>
 <2ccsnpv67gsu354uo7xe7syrxs265ncj6hl26v3cwf2dfm7hyu@ihkemyajuiag>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2ccsnpv67gsu354uo7xe7syrxs265ncj6hl26v3cwf2dfm7hyu@ihkemyajuiag>

On Mon, Mar 31, 2025 at 09:07:03AM -0400, Sam Winchenbach wrote:
> On Mon, Mar 31, 2025 at 02:43:59PM +0200, Krzysztof Kozlowski wrote:
> > Not sure yet. Can't you check the status of ICAP before programming and
> > then enable it only if was enabled before?
> 
> I am having a bit of difficulty understanding this so let's talk about cases
> where the ICAP is enabled/disabled -
> 
> 1. When writing the fabric from the driver
>    In this situation it might make sense to read the state of the ICAP
>    interface when preparing the fabric, before enabling PCAP. When the write
>    completes you could re-enable the ICAP if it was previously enabled.
> 
>    This might be outside the scope of this change - and I am not comfortable
>    enough with this use-case to understand potential side effects from doing
>    this. Logically it makes sense, but there may be a very specific reason that
>    the ICAP must be enabled after doing a fabric load or partial
>    reconfiguration.
> 
> 2. When the FPGA driver loads and is probed by the DTS
>    In this situation, which is covered by this patch, the FPGA is loaded by
>    BootROM/FSBL but contains functionality that requires the ICAP. Unless the
>    user has made modifications to the FSBL or 3rd stage bootloader there is no
>    clear way to enable the ICAP interface. Checking to see if it had been
>    enabled prior to loading this driver does not (in my opinion) make a lot of
>    sense here.
> 
>    Perhaps the name of the DTS is confusing? The suffix '-on-load' was meant to
>    indicate when the driver was loaded, not the fabric. Would the suffix
>    '-on-probe' be more clear?

Neither on-load nor on-probe, because again you instruct the OS what it
should do. You should instead describe the hardware (or other parts of
software stack). Describe the condition, the hardware feature, the
characteristic observed. With proper phrasing the property should be
fine, but I still do not see that its name and description match actual
hardware.

Best regards,
Krzysztof


