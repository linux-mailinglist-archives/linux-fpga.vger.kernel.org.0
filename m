Return-Path: <linux-fpga+bounces-681-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00A29617B1
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Aug 2024 21:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF922840BE
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Aug 2024 19:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950121D363C;
	Tue, 27 Aug 2024 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m8DRmV6k"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16D91D2F59
	for <linux-fpga@vger.kernel.org>; Tue, 27 Aug 2024 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724785550; cv=none; b=ivz0VZg9O/vUuNFCqs32h2mZdtiGFCzxTZuptcMFuIQfgXUM5NEWe5RZ2ncNBWFu0eZuBG/9FlOJG8eff1RJVboaU8ltPRkn+/voq6O2P4LUTjbjg3v8eSMPjaNysj8LJGi9sgSFL7siAbl+oBR+6AZaPxw0w+bGv80/OxqaUlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724785550; c=relaxed/simple;
	bh=g2qfOyzD7mj2ctfLhV+IRVqjYo+8o4pLyGoAVHj2xpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aB0eVZVpM7hyzTNavK7Pz8M2goH24ARyhUrQOd0t68fnO9Ts4CAF/uDYQKGHYOshLfS8NOSh2T3o5mo7KmLicoKUgFKNg8ZwIGXO9t6xBMTMLsHsFVhrIXo4UIc9qh3JFlCkdYe1cEjgZckLIHHITub3QnjIa5hglAcent8bV2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=m8DRmV6k; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-8223685fbe9so318672239f.1
        for <linux-fpga@vger.kernel.org>; Tue, 27 Aug 2024 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724785547; x=1725390347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPgtDg58q+McBQLoCDhB6dvqAm4lTGOJk5NvB5IqS60=;
        b=m8DRmV6kaV1LHryNqCjrFMqRFIqAEjBnmdg7YxEaaSJL6COGd7idy6QlK8B5XOMnZ+
         +JHVI9G8Hx+/5XfWjo+kcF44wcjk8694+405egBeivCPcBCsriCbbyqv5oFpTl4p469C
         pkj5I9dDzMSMSV+GE6/f6sFBzSQy+ypfkcJ6H0YayDDrLGi2uxGQRGJiNvDTXRRoWgwa
         Yw8uwpJI2ry0OvWu64xckonkv45AJwI4gayaoOaqSWiZ0kSo84bI5Tb2/UR3qf3W2uAw
         FdAosR/idbDqsnvCgZNVgSHCrrrG7j1RghXNxGf63FD4vD9C6OFY6ypa/WgvmtDHU3w/
         jqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724785547; x=1725390347;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QPgtDg58q+McBQLoCDhB6dvqAm4lTGOJk5NvB5IqS60=;
        b=QOrTAC5qGKd//UeWkaHCEW5vwIMEnfFVignB5rUiE0GakQdcPPkbuptmNnxjhAJHKI
         lmpXSU+/qWBZPCqjYuq0ZdSOZxJxeZRqSpMGkdmb7jCh5Ij1iC3wPbhiMRrOx/k8IIZm
         d9tcIFFKwRH9LP58XRq9ECwoJ7ga3nOQapos7UkvH4iJDDxGQqvyGuEaOZuZESOMsj+A
         p8BexAahnaqkIA7rA65Lrn2DCx0R31f5jnQCe8pvPT1ovb61lXYrXq1ZdqF0fNhZUhzh
         9ciV3kRHufxLSSPKrBWPOQyWcHuTsvVFVj53z645po3lofoJB9VpztKT9RXITsBz/JXT
         ODHw==
X-Forwarded-Encrypted: i=1; AJvYcCUcFYBEhhYtlEdFGi/rIcBFIGdowtRaRM4RuJA54OiKiBmEL3iWehALRJQpC413lwuq4xycD0TJnVMY@vger.kernel.org
X-Gm-Message-State: AOJu0YxdXzkv9QXJvbFvFRs45jllAxOCt3/osIQML4K5hg8y4IY+Vp3a
	Hd+dL8BCV/e/QVLaBgcJVmSFpFX+g0LP+qSlg/yuEapVsNITf8jUnOhheBtwPAU=
X-Google-Smtp-Source: AGHT+IEuujl/9dEsZ4FQ8JuKJxuoRbbHy6rNrvvhcf00pWo8FSAo3yeLetJirxmhnMEDUTEhU7xR4w==
X-Received: by 2002:a05:6602:13c8:b0:824:d752:986 with SMTP id ca18e2360f4ac-82787387f9amr1917557439f.16.1724785546835;
        Tue, 27 Aug 2024 12:05:46 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f20255sm2724543173.3.2024.08.27.12.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 12:05:46 -0700 (PDT)
Message-ID: <c7acca0d-586f-41c0-a542-6b698305f17a@kernel.dk>
Date: Tue, 27 Aug 2024 13:05:43 -0600
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] block: mtip32xx: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Wu Hao <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
 Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20240827185616.45094-1-pstanner@redhat.com>
 <20240827185616.45094-4-pstanner@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240827185616.45094-4-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/27/24 12:56 PM, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> In mtip32xx, these functions can easily be replaced by their respective
> successors, pcim_request_region() and pcim_iomap(). Moreover, the
> driver's calls to pcim_iounmap_regions() in probe()'s error path and in
> remove() are not necessary. Cleanup can be performed by PCI devres
> automatically.
> 
> Replace pcim_iomap_regions() and pcim_iomap_table().
> 
> Remove the calls to pcim_iounmap_regions().

Looks fine to me - since it depends on other trees, feel free to take it
through those:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


