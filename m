Return-Path: <linux-fpga+bounces-542-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107F4903919
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Jun 2024 12:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19CC285B07
	for <lists+linux-fpga@lfdr.de>; Tue, 11 Jun 2024 10:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684FB17838E;
	Tue, 11 Jun 2024 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="lo7vyE+0"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D61D7407C;
	Tue, 11 Jun 2024 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718102492; cv=none; b=qlhXlzUTZYjFDn2NTrVpbsLjrtote4oAxECyopWsKtzv9pltw8hS8d+wIM1wh6jdRv3W3LgzEcds81kqntXjaz08nx5pF3FQbj9Cov/WAb4U+OxDm0MZJON9j2qqlUrcK2TTMxBkDqC9ARroi/POO8803ZRIt85hN2VbG1PCSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718102492; c=relaxed/simple;
	bh=zyckEblzH74h7Tgi2pKhrriJeDUbb5iRCO7jCbK2v2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkn78LwDgaGMUmW9BSH3ZmZreeAqKMjEQhBzkCuoImtyjvub1bMyEpSEuBK7Nn+xnFzjG2WE0jr8lcIUNGynz7b3jLQv8OPrgtDJUFHvjlHYcqb1+/iOdPo/3bJ9TYPRj37oUbPNMRLi/PShN8n3Nvd6JA8SvchnPHlkqyr7K/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=lo7vyE+0; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=EXhrNi9BJXwqxgk9P0Sn7kFh4jE63HviHZ8ME2QK1o4=; b=lo7vyE+0ks9EwPZa
	431dVbtEFGWmIJsgkbGHeFCJGCF9JiJGKGCNpwEinMpAWQiioT6Y5mkSIQLy15MYYzB0Yl/HXFiaq
	EdKnWYTWgp+CRnE/IrgULNCVUKtFUYlrMTy9e6jWdadtejlqrSLqVSRPxz6XxfMZ9+YZFZGbqlG61
	CVVCaxJWzeEVw8Zr0/4SJLpm1ve0grQ/9wlzeu8f446h9z+MIdgnVGe7+1StjIUrGCQSTJwclNEXU
	VCg8QTE1dfdOHTLG5vnZA1yIEu7SDkSlQ8QHVmKBxc7X0hO9JQ6YoYdt82MCSmj7ZzKByqH0O0Ah9
	lL40e/Xw13zEa4pz5A==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1sGywN-005XCX-2U;
	Tue, 11 Jun 2024 10:41:23 +0000
Date: Tue, 11 Jun 2024 10:41:23 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: mdf@kernel.org, hao.wu@intel.com, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-fpga2sdram: remove unused struct 'prop_map'
Message-ID: <Zmgp01iGuYb-hHLK@gallifrey>
References: <20240530205245.125513-1-linux@treblig.org>
 <ZmgH3FakPP2w/ksI@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <ZmgH3FakPP2w/ksI@yilunxu-OptiPlex-7050>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 10:40:32 up 33 days, 21:54,  1 user,  load average: 0.01, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Xu Yilun (yilun.xu@linux.intel.com) wrote:
> On Thu, May 30, 2024 at 09:52:45PM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> This is only needed if the person sending the patch is not the author.
> 
> > 
> > 'prop_map' has been unused since the original
> > commit e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support").
> 
> Please use 'fixes:' tag.

I've avoided using fixes: on this series because it's not a bug;
stable and downstream maintainers use Fixes: to indicate that they
should pick up a patch on top of something they already have; there's
no need for anyone to backport this.

Dave

> Thanks,
> Yilun
> 
> > 
> > Remove it.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >  drivers/fpga/altera-fpga2sdram.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
> > index 6b60ca004345..f4de3fea0b2d 100644
> > --- a/drivers/fpga/altera-fpga2sdram.c
> > +++ b/drivers/fpga/altera-fpga2sdram.c
> > @@ -75,12 +75,6 @@ static int alt_fpga2sdram_enable_set(struct fpga_bridge *bridge, bool enable)
> >  	return _alt_fpga2sdram_enable_set(bridge->priv, enable);
> >  }
> >  
> > -struct prop_map {
> > -	char *prop_name;
> > -	u32 *prop_value;
> > -	u32 prop_max;
> > -};
> > -
> >  static const struct fpga_bridge_ops altera_fpga2sdram_br_ops = {
> >  	.enable_set = alt_fpga2sdram_enable_set,
> >  	.enable_show = alt_fpga2sdram_enable_show,
> > -- 
> > 2.45.1
> > 
> > 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

