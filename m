Return-Path: <linux-fpga+bounces-708-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A464B969FB9
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Sep 2024 16:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABA5A28142F
	for <lists+linux-fpga@lfdr.de>; Tue,  3 Sep 2024 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5294E2C1BA;
	Tue,  3 Sep 2024 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FQkaZOGq"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C22AE99
	for <linux-fpga@vger.kernel.org>; Tue,  3 Sep 2024 14:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372183; cv=none; b=B+jrkinw2cdtIhw/4cupoVX+f5IMhQ1X2yPE/6HAcykSgDtKQCK/syuZ87EKIrkMn7/+1YsHlIOujstAOhRaY9t/bqffBZT51Hnv6WkoLTloYekK4m9iezIck5KecOy77J55pKHjjgt5HgxBysp11+T9doFR2IZ1x1VGxm5oOYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372183; c=relaxed/simple;
	bh=KbVX5/WJLt/Z0+uhwnKhCH5C1tCBFTeakpeppFQXWBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vEPjXY4snrA4MQlqsnY0sIrgHKueQKh6bmvAR+rIWKOj+I4jN6OiNdgpN8uXUVg2nQRet16JkkjMucIi66Bv0YGdGCNmxtPk1Hh8t8jyrn2I404ET3VsHMGusQFiFrk4kvt0SrTbdLKtoBMaKFfa4xjfoeoY1FhAbQrWMBQn5FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FQkaZOGq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725372180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1T7shADQQm1E7ZhQRMDcUIIeoOERk2k982scWhmF05E=;
	b=FQkaZOGq1HkCjS1ir7eYUkniDACow0MRuk3ISxs0D8MSaPLYY9BhgaRXvEhmK0QaMCD0th
	yrQ1k72np2fy2LsnCZ/SCMDqHhqGiBSP5MepxVkwRuLYXc+LFrzhSrOXsGl+wsXMWiN6TV
	OyBQilEmvV3sTCOr8XWFPWSgqgskn4A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-TnbpzMzWO-CjrvsigT9hVA-1; Tue, 03 Sep 2024 10:02:46 -0400
X-MC-Unique: TnbpzMzWO-CjrvsigT9hVA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-374c960ee7aso1811995f8f.3
        for <linux-fpga@vger.kernel.org>; Tue, 03 Sep 2024 07:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725372164; x=1725976964;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1T7shADQQm1E7ZhQRMDcUIIeoOERk2k982scWhmF05E=;
        b=tOI+ofVbIE8b/flFSZvJ7Akr5O+zPFnC2lxECIV8amWVhadCPr0gow4dCzIOG/qOkh
         wbdp8+XWJbdy4bHkfem40ZHy+RCLYFuVfzZGF/BGBSskW7Exm42vD1tu9ynnXHvI8Pcz
         hq7S+ORREAo7l+fQ3k9uZnq6NJ+vmfN0hh1eIwROUcDxgM71KleO5bfUc8Ysq8lR+E5f
         /bbs7xxhM/rLsZfMhr92lI72zIrEsl8CAxaizGRKTNwT0SZRD5fz5UqjfJgWo7sR0fnM
         UVGTjLmSWjwWTP8G7KR6FXON8t2KJPFzo7ckRBIvu5qMX/S2yv7b9NcJhUoRcTuR6I1/
         cXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1OnkR071hJZiPj0YhLkM4LJKpQ8CdhaiCgLXfhyETQC56uCGCxyEAxlrjX/2+97Immy8Xj/+gxUYe@vger.kernel.org
X-Gm-Message-State: AOJu0YxZdXnkUggqHetxagAmtXl4RrMOOpxqDoyNxyTDBBbgHHF1cTHl
	C/AUlVy7EIvAx/j1rdAuxVuHlBwFodHC2I4ld8s3ZL+sm+OgLWJnzsbB9EZOrzwzSeLLo5vYYjq
	U1i0zKsKc1pxwRq27Dr4UOWkUJoGU06YN1D24fsinAuG7fRbwHeJbUEU6WzA=
X-Received: by 2002:a5d:5c87:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-374c8eb9b69mr5013547f8f.24.1725372164310;
        Tue, 03 Sep 2024 07:02:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGG+gCA4emCQ8lN+v2r+4PD0Xf7gtP5260Hobybyq26ysa18Yk2eN574I3dEkpcvY9bhrHY7Q==
X-Received: by 2002:a5d:5c87:0:b0:374:c8eb:9b18 with SMTP id ffacd0b85a97d-374c8eb9b69mr5013434f8f.24.1725372163170;
        Tue, 03 Sep 2024 07:02:43 -0700 (PDT)
Received: from [192.168.88.27] (146-241-55-250.dyn.eolo.it. [146.241.55.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm14372770f8f.50.2024.09.03.07.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 07:02:42 -0700 (PDT)
Message-ID: <c5658b79-f0bc-4b34-b113-825f40a57677@redhat.com>
Date: Tue, 3 Sep 2024 16:02:39 +0200
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] ethernet: cavium: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>, Jens Axboe <axboe@kernel.dk>,
 Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@bgdev.pl>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
 John Garry <john.g.garry@oracle.com>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
References: <20240902062342.10446-2-pstanner@redhat.com>
 <20240902062342.10446-7-pstanner@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240902062342.10446-7-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 08:23, Philipp Stanner wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> pcim_iomap_table(), pcim_iomap_regions_request_all()").
> 
> Furthermore, the driver contains an unneeded call to
> pcim_iounmap_regions() in its probe() function's error unwind path.
> 
> Replace the deprecated PCI functions with pcim_iomap_region().
> 
> Remove the unnecessary call to pcim_iounmap_regions().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


