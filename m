Return-Path: <linux-fpga+bounces-537-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709D78D6730
	for <lists+linux-fpga@lfdr.de>; Fri, 31 May 2024 18:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A684228CA26
	for <lists+linux-fpga@lfdr.de>; Fri, 31 May 2024 16:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA3171E59;
	Fri, 31 May 2024 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qAcLVQX0"
X-Original-To: linux-fpga@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8552D16F904
	for <linux-fpga@vger.kernel.org>; Fri, 31 May 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717173971; cv=none; b=kmTtSU5V24hE8wJgivgNS9UX0T39rNQk1G37cwuRxtZ/EJi3XZFK00wH/HYi8bxn4Z3m3VE8/d6+yKNOHL/t+kDNlQn5o8mJkGoq7X3pjESrVXty6ISg/xhBOA8RxkUywBx8niOyK0IcnK4myyqqUA31USoatNSMYrwc5FnPC6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717173971; c=relaxed/simple;
	bh=BHSXkui0lLJDwsM6K2VIyUbKpHvakWJy4/2dniX7WHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+6mJJR+g5YWg0YyHkj9+AHMm1lhgiIWNbScCaZpNAGCqbsY2TbJoWhdmYK8+xr0iqzghDMwD/a/yJ598aA5Pp4rRyLOU6YqmXoJmqOjXgdm99Nbh1zhvMHQNR4FZpvRlG7EhvzxuAZidx2QIN0Vw7TJsGK73DXHqB86oRb6ty8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qAcLVQX0; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux@treblig.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1717173966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AGWvFs3TxF1V6crIaP8oj20Lg2Wpik7E6/yILGyWVPw=;
	b=qAcLVQX0NqZce7vw6dkvVIbzKA9W5krvKmRfnNH8PYDC2unI/iHjZ1olFx1NoMVPcgVrgj
	mN1f34NkajoOX177utpIRtUihpjOvBCnzNSAA+SlGNRcmGuMOsTc4x5wbMv6h1+Hys7tLI
	QNxL0Z6Op554tFHecjpeyoQq3YvhqrE=
X-Envelope-To: mdf@kernel.org
X-Envelope-To: hao.wu@intel.com
X-Envelope-To: linux-fpga@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Fri, 31 May 2024 09:45:55 -0700
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Russ Weight <russ.weight@linux.dev>
To: linux@treblig.org
Cc: mdf@kernel.org, hao.wu@intel.com, linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fpga: altera-fpga2sdram: remove unused struct 'prop_map'
Message-ID: <20240531164555.kkleqsmhon72wxol@4VRSMR2-DT.corp.robot.car>
References: <20240530205245.125513-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530205245.125513-1-linux@treblig.org>
X-Migadu-Flow: FLOW_OUT


On Thu, May 30, 2024 at 09:52:45PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'prop_map' has been unused since the original
> commit e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Russ Weight <russ.weight@linux.dev>

> ---
>  drivers/fpga/altera-fpga2sdram.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/fpga/altera-fpga2sdram.c b/drivers/fpga/altera-fpga2sdram.c
> index 6b60ca004345..f4de3fea0b2d 100644
> --- a/drivers/fpga/altera-fpga2sdram.c
> +++ b/drivers/fpga/altera-fpga2sdram.c
> @@ -75,12 +75,6 @@ static int alt_fpga2sdram_enable_set(struct fpga_bridge *bridge, bool enable)
>  	return _alt_fpga2sdram_enable_set(bridge->priv, enable);
>  }
>  
> -struct prop_map {
> -	char *prop_name;
> -	u32 *prop_value;
> -	u32 prop_max;
> -};
> -
>  static const struct fpga_bridge_ops altera_fpga2sdram_br_ops = {
>  	.enable_set = alt_fpga2sdram_enable_set,
>  	.enable_show = alt_fpga2sdram_enable_show,
> -- 
> 2.45.1
> 

