Return-Path: <linux-fpga+bounces-1095-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C84A4DC97
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Mar 2025 12:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F9718887B0
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Mar 2025 11:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C8D20011E;
	Tue,  4 Mar 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="szojJJVZ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE46D1FF7D5;
	Tue,  4 Mar 2025 11:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741087813; cv=none; b=npt2OV2j/jlYALVokrRccU+9E3iroNwfppu2qnu9BbUBtgV/DfvhlKH/qC3xRwaGNOu7i09NqxEXEpOty3kuQlGCHJWTyvqhSyjiejJIUoG5mkLGOo6/K6ww0J5rwV2kwpxb4p225ftHWbu1sPYa9ag0k4HU3dAqavYRs8QpcEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741087813; c=relaxed/simple;
	bh=4NlApes1uMZR/fEzD45gw5HtUBzCox4wK22duVcC3eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr67NKr0lX+030JT0ILFyTzNfcBt1Ad8zyo2QlWh6CEirKzZWue4PeKg61N9sM54pf3qmPtfL7erDc/ThB1bQS5gxvkz8bTlR+b+XJ5ZG29GKN7xaXDEpjfjz8GKOT+PdPRrbHpKhwJ+mlvLLdLAPajITbc+urJikqOIRNYjKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=szojJJVZ; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5B6411480850;
	Tue,  4 Mar 2025 12:24:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1741087453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5abHVWwaHFEi1aRUSGkWCShuUKq/Uu+o+daM4oBhLRc=;
	b=szojJJVZWk6XvOFPNdubWFEz43mbBbNVI+FB/KEk1K4r9ta2Gl+uI5T8z8P/l250boNeID
	NjMViqUfeEzM+JoLZadkW4Ts7XUuc+pwSwa3vXIIDL+e1HXLp57r16IKMbx4pPOeV9DPHm
	hEZJ+1R0nZYepTOgcTuvBVR576HtQVrxQ3Dh7t35Z+bKEG6lah6Bnt/K0TbKAT22bUrzMj
	acNOqP0r4bYc7B4dwo8iRwKG7uuumXPrZtNFJv66c0je01nsbvzLyUJaIUODKg4Sf7sAYG
	V65jMLIJYe9IRdBCINX5K21zFfa8JsY2Kg/cfqB5cvCs7uPHaRQo2eiQhLXpBA==
Date: Tue, 4 Mar 2025 12:24:02 +0100
From: Alexander Dahl <ada@thorsis.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: iansdannapel@gmail.com, linux-fpga@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [v4 1/3] dt-bindings: vendor-prefix: Add prefix for Efinix, Inc.
Message-ID: <20250304-despite-knee-8b528b8f7f4c@thorsis.com>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
	iansdannapel@gmail.com, linux-fpga@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
References: <20250228094732.54642-1-iansdannapel@gmail.com>
 <20250228094732.54642-2-iansdannapel@gmail.com>
 <cf8b754e-f4b1-40f2-86df-e1f0cbf07189@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf8b754e-f4b1-40f2-86df-e1f0cbf07189@kernel.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Ian,

Am Sat, Mar 01, 2025 at 02:10:38PM +0100 schrieb Krzysztof Kozlowski:
> On 28/02/2025 10:47, iansdannapel@gmail.com wrote:
> > From: Ian Dannapel <iansdannapel@gmail.com>
> > 
> > Add entry for Efinix, Inc. (https://www.efinixinc.com/)
> > 
> > Signed-off-by: Ian Dannapel <iansdannapel@gmail.com>
> 
> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new versions
> of patchset, under or above your Signed-off-by tag, unless patch changed
> significantly (e.g. new properties added to the DT bindings). Tag is
> "received", when provided in a message replied to you on the mailing
> list. Tools like b4 can help here. However, there's no need to repost
> patches *only* to add the tags. The upstream maintainer will do that for
> tags received on the version they apply.
> 
> Please read:
> https://elixir.bootlin.com/linux/v6.12-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>

FWIW I guess this might refer to:

https://lore.kernel.org/linux-fpga/20240930-tranquil-glitch-f48685f77942@thorsis.com/

Greets
Alex

> 
> Best regards,
> Krzysztof
> 

