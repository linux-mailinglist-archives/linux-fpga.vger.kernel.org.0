Return-Path: <linux-fpga+bounces-1327-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15408B2B89A
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Aug 2025 07:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730D81B61142
	for <lists+linux-fpga@lfdr.de>; Tue, 19 Aug 2025 05:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6EA24C07A;
	Tue, 19 Aug 2025 05:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1dIrB5q5"
X-Original-To: linux-fpga@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E832AEFD;
	Tue, 19 Aug 2025 05:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581162; cv=none; b=SQTlq4/m5Ls8drfapQ3TdfLsCTXwu5B0w48kmDQUCQsEAhSB69M1S6/W9g8Ulysgoz+wsjhKFZKObQt4+iL2uNtzyWgGKLwnY2y9QJa8b12ZiLhF9vHzihhJZGDv2V5nI5rXE0FJPBkP/7krDX54ZHVJEgHpbWll+wWma3UAVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581162; c=relaxed/simple;
	bh=os61l//22siihSz+hyw4bvM5SMXpC9bUP3xOgVQRO4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzrTkRwY4zG0OxQ8In+bEt11fmgCsq/su3H+jbFrrEvI2m7Xdv5o7ZXP4Wnaa+YOkvMrVM0JUhT1pK9XdjHH+ZZ2Q2jtm6wl4REIIGSRW7WJI2e99dFUNEKjiIHSonB1fsMbGQQqmTgKfn/xjaFJtJuUhowpbXD5Sw4YgoIU1QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1dIrB5q5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A56C4CEF4;
	Tue, 19 Aug 2025 05:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755581161;
	bh=os61l//22siihSz+hyw4bvM5SMXpC9bUP3xOgVQRO4A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1dIrB5q5bDTcS/QbH4Hd765zd+Ucl6ZN2UoWqD5EjDZT79Zc4hLvjPBu6FUW8IHc2
	 4CjeT8ObSukA5hsdn3ssbD+MSJJav7YzG4x5QHj7zhGeDejxpWcusZNSYOd3SQXojy
	 2s2C0rT5+ceHeRBq1RKFnlKsi4o9bamZdy7DnzR4=
Date: Tue, 19 Aug 2025 07:25:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pavel Pisa <pisa@fel.cvut.cz>
Cc: Xu Yilun <yilun.xu@linux.intel.com>, jgg@nvidia.com,
	m.szyprowski@samsung.com, yilun.xu@intel.com,
	linux-fpga@vger.kernel.org, mdf@kernel.org,
	linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/1] fpga: zynq_fpga: Fix the wrong usage of
 dma_map_sgtable()
Message-ID: <2025081907-wireless-entail-08d5@gregkh>
References: <20250806070605.1920909-1-yilun.xu@linux.intel.com>
 <20250806070605.1920909-2-yilun.xu@linux.intel.com>
 <202508190039.02454.pisa@fel.cvut.cz>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202508190039.02454.pisa@fel.cvut.cz>

On Tue, Aug 19, 2025 at 12:39:02AM +0200, Pavel Pisa wrote:
> Hello Greg and others,
> 
> please, is there some progress/decision about the fix for mainline?
> 
> Our daily test of mainline Linux kernel build and test of CAN
> communication latency on Zynq system with loaded CTU CAN FD
> IP core ends with unresponsive kernel. The last successful
> mainline build is from July 29
>  
>   run-250729-042256-hist+6.16.0-g283564a43383+oaat-kern.json
>   https://canbus.pages.fel.cvut.cz/can-latester/
> 
> I have analyzed the cause and reported (August 4) that mainline
> Zynq runtime FPGA bitstream loading was broken by patch
> 
>   37e00703228a ("zynq_fpga: use sgtable-based scatterlist wrappers")
> 
> Xu Yilun and others from the FPGA community reacted promptly
> with the fix on August 6. The fix has propagated into linux-next.
> Is there a plan to accept it for the 6.17 version, or would it be
> accepted only for 6.18?

It's in my "to apply" queue to get to for 6.17-final.

Please give us a chance to catch up, August is usually a time for
vacations :)

thanks,

greg k-h

