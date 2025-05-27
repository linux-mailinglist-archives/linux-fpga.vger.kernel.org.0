Return-Path: <linux-fpga+bounces-1228-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC812AC4E74
	for <lists+linux-fpga@lfdr.de>; Tue, 27 May 2025 14:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DF1D7AED24
	for <lists+linux-fpga@lfdr.de>; Tue, 27 May 2025 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA582741BC;
	Tue, 27 May 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PXI++bkF"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AEC270ED7
	for <linux-fpga@vger.kernel.org>; Tue, 27 May 2025 12:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748347892; cv=none; b=ABHCelxJCQd5LrQlAYo2SpnbmHCN4gxX6iUfRqtayqta7YrJpSrRQGxldyOpy7TaHFcsf9oHAf0XoW46olMlGJP2AT34XW76FlqS5OiV1lUOEw9EILkor1Gewl406nrzRVJeX7xqQxIFfNmX6wMC84nOw+95fWz5rQtLis+uEOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748347892; c=relaxed/simple;
	bh=N0jjmf/kmkyvAxAXac21ttYuTZnd34V4RTWarAbSnHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i+Gnvd2wGOa8OYkEb8RVvH/SMASiAKADJlnEaXcsKbdNAvaTy7UfMc/fA+H+nusntkSAkH/QvuMlRHIeqjYJmTOTRfkJqkV919JwyKqMdW2otH7JQZV2Vyk3Eg7JvkI6QhS1FUN+cb1o+D6RuCC2mAEgx4sxi9mW/YwUBWXs1gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PXI++bkF; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fa9ce24d44so67185496d6.1
        for <linux-fpga@vger.kernel.org>; Tue, 27 May 2025 05:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1748347889; x=1748952689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7XDEIh7cWs+9i/urKEMylLez5Ew3kmQCefiIWKozcak=;
        b=PXI++bkFpkZ4yCBjPm14L/h4cT3lkPuSoENrTrdOa6/Np+Q0OlTVs3uH752cilqY6v
         /D9p0wwJmPNLvjM8ido3qLSFCLDRq35B9O9VhsAIxhfrHzpK1phJ8eTul2PFE/MDeP+x
         PVZ42b5c1h7lPq4bfITr15vlwcK5vK+t2B3nmMVHW6zeD9uFeDwT91wqGYxhYFkox//K
         9NDR9I2AMJXyC6qcMTZcA9eZ1ehlg8TmDXmVwAV4RT8GMwsw3PrVSCFmEfNUAvMhY+pQ
         HQ+4qfHA2T7tJbvHOIWM+ZDB6n6rWQ5v3kRRn0VdCXsW1Wv1FghIm0wZTLvRF4xXNPva
         A64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748347889; x=1748952689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7XDEIh7cWs+9i/urKEMylLez5Ew3kmQCefiIWKozcak=;
        b=B6VcGA6Fqw21hrpKjCFmqTYHCbqZC2AA9WdE8e7TmoKv9/gc/AXbalAkw4lr0bnMTK
         91aYKir7+/mtxxk/AOPkSRkmjZhvmwuW5NAzMuMLq8QZY1zedPD3T1vZGgj+Z5d9/NrZ
         7LAcVsDjRClZX3oAcZHCrUheVjbKp87ITOAM9ISm+FeZX5RL844DvsEfJCYDanPsnpKF
         9j5PxuDMsAHwxK/q0istYhPoRQ/Ymh+Zubjw/jxX6HsHuwa38orOx4WdNSfhYEFBDQ6D
         hoFIJh8MZ4qrmuKO1hYw5NXRhovphn2heIm4Xlk9GHp6YaWoNnvTuzIkZMJeZz2ZbyfF
         NFlA==
X-Gm-Message-State: AOJu0Yyt6d/LmCpx8/aUSvdFxCf4N7XTbkPzPVk1Jmh19Ip9YdojFVdX
	LSJeb/Gey8B/0Exfl5nKGYe0LxQ/bOTfwd8KzsGJQvan1MyBUNx7d7X0UREFlw5w5+Y=
X-Gm-Gg: ASbGnctvRFI81x7tDPDQ65tOIM0YXVw44GpfiRUppZNwMdAhuudn+0VhiJzeL6srjXo
	2IFPXCvNYXqY1hUt7ci9P5vg41l+/TBLXFHKEh42dZoz+W70CE2eHio5ybhDRGrc/sD5kIeeXVJ
	zzTzKRjkZrKuz6B2klJZj84zizYo7xTINmirVDlOjNCTs0+T/wLJ4YFFlZhBfnEfa8QJzouDcY1
	67JpKWKy9ffIT/dRJ2twHqQGbEkrvRd693uYNHi4msAvJebhMob7AVt8Rj/KnAoZAIsx7wxrwjK
	BZz1xJfg5oeHop6j+ssbWkyVc8yFF1jpl31pzAOCU0qkUSl9ms8cPs/nmC/ptM1LWICJelpYeRE
	hgeGk6qnS4jH94GvZfa64d1ZhY0qsoQTYtC36ig==
X-Google-Smtp-Source: AGHT+IGOFTXFB5+rAUr8E/GqCzuxsYlYPeiD9+d/FGPHL3B5HdbhA3MJLfSRW3SyI7yXaYSDYR+MhQ==
X-Received: by 2002:a05:6214:20e5:b0:6e8:f2d2:f123 with SMTP id 6a1803df08f44-6fa9d27eea4mr230852526d6.13.1748347889555;
        Tue, 27 May 2025 05:11:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-56-70.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.56.70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6faa3704157sm42245476d6.36.2025.05.27.05.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 05:11:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1uJt9U-00000000ZUZ-2C0j;
	Tue, 27 May 2025 09:11:28 -0300
Date: Tue, 27 May 2025 09:11:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, Michal Simek <michal.simek@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] fpga: zynq-fpga: use sgtable-based scatterlist wrappers
Message-ID: <20250527121128.GB123169@ziepe.ca>
References: <CGME20250527093152eucas1p24a904b0d973252ebc0d05034a276e9cf@eucas1p2.samsung.com>
 <20250527093137.505621-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527093137.505621-1-m.szyprowski@samsung.com>

On Tue, May 27, 2025 at 11:31:37AM +0200, Marek Szyprowski wrote:
> Use common wrappers operating directly on the struct sg_table objects to
> fix incorrect use of statterlists related calls. dma_unmap_sg() function
> has to be called with the number of elements originally passed to the
> dma_map_sg() function, not the one returned in sgtable's nents.
> 
> CC: stable@vger.kernel.org
> Fixes: 425902f5c8e3 ("fpga zynq: Use the scatterlist interface")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/fpga/zynq-fpga.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

