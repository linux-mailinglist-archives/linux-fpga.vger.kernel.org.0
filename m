Return-Path: <linux-fpga+bounces-1132-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD65A7668F
	for <lists+linux-fpga@lfdr.de>; Mon, 31 Mar 2025 15:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEA21658BD
	for <lists+linux-fpga@lfdr.de>; Mon, 31 Mar 2025 13:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D852116E9;
	Mon, 31 Mar 2025 13:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b="TKLOJmIT"
X-Original-To: linux-fpga@vger.kernel.org
Received: from out-16.pe-a.jellyfish.systems (out-16.pe-a.jellyfish.systems [198.54.127.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64181DF73C;
	Mon, 31 Mar 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743426445; cv=none; b=jRzrTtYc89QC4yg1yUZ4XynhtDLZrX6Czcqde6nF7gmo8zI0RKqcP0c2cnjqaFnVE89zbCsWf0kxBjF1kb7ok113B9T2MMORv42nSWjn/RUmo16VgWOXi9p5uJWldWcdAZXflx6B5Akxp3cm/uF+3IPBkoKgV51FVrPD2ijialw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743426445; c=relaxed/simple;
	bh=XAf34DaNZayKTZMezBU2SOnWNVi58X5xnCWEMzzxUdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rk3MHUxe3dXa6sd/vy16eqnOdmMAv5zCg2pxNYUMvB859qEuiMafifxcuz2SFUahSP1TeBSxctbTEnAX+vtYDppWZ8CP3sgDma7WNKpHk1raaVlOi8P5nrMLLg9GJKIDYBpvRUPVNwdujR8LklkdakHyuOrvqI+FjCHq10Z7UFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org; spf=pass smtp.mailfrom=framepointer.org; dkim=pass (2048-bit key) header.d=framepointer.org header.i=@framepointer.org header.b=TKLOJmIT; arc=none smtp.client-ip=198.54.127.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=framepointer.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=framepointer.org
Received: from prod-lbout-phx.jellyfish.systems (new-01-3.privateemail.com [66.29.159.56])
	by pe-a.jellyfish.systems (Postfix) with ESMTPA id 4ZRBHT1fDlz4wJq;
	Mon, 31 Mar 2025 13:07:17 +0000 (UTC)
Received: from MTA-09.privateemail.com (unknown [10.50.14.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by NEW-01-3.privateemail.com (Postfix) with ESMTPS id 4ZRBHT0j32z2Sd0Q;
	Mon, 31 Mar 2025 09:07:17 -0400 (EDT)
Received: from mta-09.privateemail.com (localhost [127.0.0.1])
	by mta-09.privateemail.com (Postfix) with ESMTP id 4ZRBHS6LlKz3hhV8;
	Mon, 31 Mar 2025 09:07:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=framepointer.org;
	s=default; t=1743426436;
	bh=XAf34DaNZayKTZMezBU2SOnWNVi58X5xnCWEMzzxUdk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TKLOJmITEmXEBpX+lbpAlM2Dji1iMpPnX5u0rMJHfTPPpDFn28v0BGAY1er+GG1Ve
	 xT5NvcH+J5ce9CjXHsHmYaVHEEjf4eC9+VirK/idvZB7JE4UpxVPa10Vap/BdkkNNs
	 yg/Swd77PKX+cweoz85KxjuA5N5j2B/qNPAhMZq/XEHxS/QSF9f6gIAl2f8301b3kq
	 rVLOVDuaRy0c0PrSXY4g/b2AdWwCfCIYWKTO1RnoUlBa7qAS47tTR3ekii4BRco8kM
	 2OJlk8OB74RcJt8G8WqZ/U8psvrfNjGzPiuqUaaVwNMoxG/QA98yTGVookS6cu0fYa
	 B3pYk+p061smA==
Received: from 65YTFL3.secure.tethers.com (unknown [152.44.190.141])
	by mta-09.privateemail.com (Postfix) with ESMTPA;
	Mon, 31 Mar 2025 09:07:00 -0400 (EDT)
Date: Mon, 31 Mar 2025 09:07:03 -0400
From: Sam Winchenbach <sam.winchenbach@framepointer.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org, mdf@kernel.org, hao.wu@intel.com, 
	yilun.xu@intel.com, trix@redhat.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, michal.simek@amd.com, linux-fpga@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Sam Winchenbach <swinchenbach@arka.org>
Subject: Re: [PATCH 1/2] dt-bindings: fpga: zynq: Document ICAP on boot
Message-ID: <2ccsnpv67gsu354uo7xe7syrxs265ncj6hl26v3cwf2dfm7hyu@ihkemyajuiag>
References: <20250328141944.119504-1-sam.winchenbach@framepointer.org>
 <02496a88-3d9c-49ee-93ab-8f1400fc0c6b@kernel.org>
 <p4bujnmgkcvsu4qipmgh2j2loedepmwgp7zlaxrurhaveb6tbc@ibqtbjnbzdzj>
 <14b12882-119d-4c24-9634-e4cc37a39212@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14b12882-119d-4c24-9634-e4cc37a39212@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP

On Mon, Mar 31, 2025 at 02:43:59PM +0200, Krzysztof Kozlowski wrote:
> On 31/03/2025 14:30, Sam Winchenbach wrote:
> >>
> >>> +    type: boolean
> >>> +    description: If present, the ICAP controller will be enabled when
> >>> +      the driver probes. This is useful if the fabric is loaded
> >>> +      during the boot process and contains a core, such as the SEM,
> >>
> >> I don't get how this is suitable for DT. If you decide to load the
> >> fabric from driver, that's driver decision so not DT.
> > 
> > Before writing the fabric to the FPGA the driver disables the ICAP, enabling
> > the PCAP. Once writing is complete it unconditionally disables the PCAP,
> > enabling the ICAP. This patch just makes it so, depending on the use case,
> > the ICAP can be enabled at boot. This will not prevent the system from being
> > able to load a fabric through the driver. I added in this boolean so existing
> > behavior would be maintained.
> > 
> > Do you recommend another approach such as writing to a sysfs attribute to
> > switch from PCAP to ICAP?
> Not sure yet. Can't you check the status of ICAP before programming and
> then enable it only if was enabled before?

I am having a bit of difficulty understanding this so let's talk about cases
where the ICAP is enabled/disabled -

1. When writing the fabric from the driver
   In this situation it might make sense to read the state of the ICAP
   interface when preparing the fabric, before enabling PCAP. When the write
   completes you could re-enable the ICAP if it was previously enabled.

   This might be outside the scope of this change - and I am not comfortable
   enough with this use-case to understand potential side effects from doing
   this. Logically it makes sense, but there may be a very specific reason that
   the ICAP must be enabled after doing a fabric load or partial
   reconfiguration.

2. When the FPGA driver loads and is probed by the DTS
   In this situation, which is covered by this patch, the FPGA is loaded by
   BootROM/FSBL but contains functionality that requires the ICAP. Unless the
   user has made modifications to the FSBL or 3rd stage bootloader there is no
   clear way to enable the ICAP interface. Checking to see if it had been
   enabled prior to loading this driver does not (in my opinion) make a lot of
   sense here.

   Perhaps the name of the DTS is confusing? The suffix '-on-load' was meant to
   indicate when the driver was loaded, not the fabric. Would the suffix
   '-on-probe' be more clear?

Let me know your thoughts,
-Sam

>
> Best regards,
> Krzysztof

