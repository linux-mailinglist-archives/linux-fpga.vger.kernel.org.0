Return-Path: <linux-fpga+bounces-1105-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FED8A5DFC2
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Mar 2025 16:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3B573B215A
	for <lists+linux-fpga@lfdr.de>; Wed, 12 Mar 2025 15:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB722500BE;
	Wed, 12 Mar 2025 15:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IyEoDS2b"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDF72505B7;
	Wed, 12 Mar 2025 15:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792039; cv=none; b=AcrrXzKjXzKtXVXCgkKenUcV/B/64a5VXsX6kXdVi7vdSpZ+kkJ+847f0QDRwRvCu5szI6TbIlmUOKmmS0wkRTxlEOidIyPxb+HqdzuPFJazcwRk/MRA/8bEYLAlOCaePTGrZZYGkK1xI80pEBlxLMnBIZ+cv8y4Xsv6sQ7WL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792039; c=relaxed/simple;
	bh=Se7dJCOHygh/Ix4OxsOUpCvp5TXO6X3D/g2L8B6xnpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRuRp7T7tvf+2uHE+wp9D3ccK74m4yYxgS0T+8Y3sV3dG4BUWPjKpOkLnRWrvP547XjJC4168Faw0CHuW8PUTAb/jjf+BMeQBu0uZAWcdDZaErS2nzPpI45FMiPnnLlKP/r7iwOM00HDTL1rNafZH8kvDqsM9CAiTfDtVRHS5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IyEoDS2b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDC5FC4CEDD;
	Wed, 12 Mar 2025 15:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741792038;
	bh=Se7dJCOHygh/Ix4OxsOUpCvp5TXO6X3D/g2L8B6xnpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IyEoDS2bz1WD6BjY34unecgaTfdLyNJPi7H27yB0XxJo5MCRDbla05lmA3/23J5tM
	 ECa5SNFKAaftjsXvGma1PkcH4EmLSCL0cYCs2mNSNY4aKPH5GkGXdQms+bQWKRiNdm
	 mO9hYYtOPvNLlAiGtpPNDfH/7je04eyUvpEfwiXs=
Date: Wed, 12 Mar 2025 16:07:15 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Qasim Ijaz <qasdev00@gmail.com>, linux-fpga@vger.kernel.org,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Marco Pagani <marpagan@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Russ Weight <russ.weight@linux.dev>, Tom Rix <trix@redhat.com>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH] fpga: fix potential null pointer deref in
 fpga_mgr_test_img_load_sgt()
Message-ID: <2025031209-provider-docile-fbc3@gregkh>
References: <20250311234509.15523-1-qasdev00@gmail.com>
 <27efccdc-3400-46b9-9359-4b2a6c8254e9@web.de>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27efccdc-3400-46b9-9359-4b2a6c8254e9@web.de>

On Wed, Mar 12, 2025 at 02:01:48PM +0100, Markus Elfring wrote:
> …
> > zero it out. If the allocation fails then sgt will be NULL and the
> …
>                                  failed?
> 
> 
> Can a summary phrase like “Prevent null pointer dereference
> in fpga_mgr_test_img_load_sgt()” be nicer?
> 
> Regards,
> Markus
> 

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

