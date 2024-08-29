Return-Path: <linux-fpga+bounces-693-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F7C96482D
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Aug 2024 16:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081191C2270D
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Aug 2024 14:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118D71B140E;
	Thu, 29 Aug 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKH/uEOB"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D849F1B0120
	for <linux-fpga@vger.kernel.org>; Thu, 29 Aug 2024 14:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941431; cv=none; b=WgRvdL3OL1TeYKwhDCtyEJKpwNCsqPAkDvl6MGlNBg7DatVk+3Uv7F4wxL2AhPxo8vEJ8Dz6Acbbm2tI4hIxlCVkrgGrq+bjpH+5u8ftph3ezDWF/IjDLCEWotxJi9VVtGJoziDKenZWv1HTqRgp0AtN7GtxcQw4YJPGYmimJOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941431; c=relaxed/simple;
	bh=qPoGd42IBzZ4QGCIKQdm0vMwov6rl40Xn2loXjcYRCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nETBExlDK7IRdRJG2ZQzdQYLgd0SFBOpwMUJkAAk0GGMHS7Q04vTCZXjwQc5pwgt5XgRR64UzCBWRfKh937criBRyVIfTehzmNxqtOEoxwHGxopwLKNupU4qgwag5+kGlnxH1WjugF1I3HgYJtQHolMNMdWfpH3S8kDUJyZI1A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKH/uEOB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ql1Ne45LZaHMxqlqyDYKdi5gydRbYI8USnMenQZimU8=;
	b=AKH/uEOBYDFppaAvg6GRgH66oL7zuYQ4LrSDgv/nra99S56J1BKAlqiKSTlQupV686Vo94
	0g/btCzQAPXXvGI9Hd76+OVPUR/nz8oZfIVuoxeEg7EdOEQdfdstBYxJf9bZQboMWQvfip
	DOMNwDcnWhEpjPOQL9QeqazoK31pADE=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-6czdncBtPquoj4jrJeCOVg-1; Thu, 29 Aug 2024 10:23:46 -0400
X-MC-Unique: 6czdncBtPquoj4jrJeCOVg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53340bcd229so909880e87.0
        for <linux-fpga@vger.kernel.org>; Thu, 29 Aug 2024 07:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941425; x=1725546225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql1Ne45LZaHMxqlqyDYKdi5gydRbYI8USnMenQZimU8=;
        b=wAmvhwpTB1K//yOjo5xAZg4TOuydbQR6Oc3H29TZfI7KmQ5btu6PSD+znQy1Om0VcV
         emELnifen09/XIqRXBR089T9ctiixMFzIIEJAGi5qNc8reK2dY9sgTtPq/EiAIB0j99k
         6Hn3EOAhMSJ82X7t3fjEIDTP+mpe0RDwWDRWpXQcOWckqCA9yuDM/q/rOIgKwJZhtFdm
         U6AlFIuIaGv9o4kJXTw4ocCJ8+fDy3wxP8b+Y7teIHQjs0Zzmlsu6EVc+i7CLWJFrmVt
         Hs/V+Mk4lqpNJSkmPijwwUhMq9RTJ1jVonIRL5C52ekR/YjwektEVfH1CvwFAwG4TQWh
         wZYA==
X-Forwarded-Encrypted: i=1; AJvYcCWG2WixHc5zBLB8QFhcC7vWtsKYQ3KJhJhHFXsamXPl9txzxe+ATR1FDDqG2HreHtHpeSnocytZVVeF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/juX3HdQZnQiYTnOq2FPS2YkdesXNcC+fPci7rjRMMEHi/ifm
	JlbvTdQNYfN+mK/siCVrxS0eK26QGEwpUOw6pfvVVXPndY8OitkqWVg9iUaY+YqPNgX2m7Jdtog
	agqCFkR6vkWW9J4p7vHvm1YgTZ9ucFx08uezPQ2BhTXeZyJZ5TrZWP1m4AE4=
X-Received: by 2002:a05:6512:3e1b:b0:532:fb9e:a175 with SMTP id 2adb3069b0e04-5353e54320emr3380662e87.6.1724941425062;
        Thu, 29 Aug 2024 07:23:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFORO8WjY/vuiIa32r8sJHMtCMpPhEFpMY3fd+SrJTy3Fj3cveqXXWkkApSrWhroGzyUo6WIg==
X-Received: by 2002:a05:6512:3e1b:b0:532:fb9e:a175 with SMTP id 2adb3069b0e04-5353e54320emr3380605e87.6.1724941423996;
        Thu, 29 Aug 2024 07:23:43 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:f3dd:4b1c:bb80:a038:2df3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891a3e52sm84049166b.116.2024.08.29.07.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:23:43 -0700 (PDT)
Date: Thu, 29 Aug 2024 10:23:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, virtualization@lists.linux.dev,
	stable@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v5 6/7] vdpa: solidrun: Fix UB bug with devres
Message-ID: <20240829102320-mutt-send-email-mst@kernel.org>
References: <20240829141844.39064-1-pstanner@redhat.com>
 <20240829141844.39064-7-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829141844.39064-7-pstanner@redhat.com>

On Thu, Aug 29, 2024 at 04:16:25PM +0200, Philipp Stanner wrote:
> In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed to
> pcim_iomap_regions() is placed on the stack. Neither
> pcim_iomap_regions() nor the functions it calls copy that string.
> 
> Should the string later ever be used, this, consequently, causes
> undefined behavior since the stack frame will by then have disappeared.
> 
> Fix the bug by allocating the strings on the heap through
> devm_kasprintf().
> 
> Cc: stable@vger.kernel.org	# v6.3
> Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Closes: https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr/
> Suggested-by: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>

Post this separately, so I can apply?


> ---
>  drivers/vdpa/solidrun/snet_main.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
> index 99428a04068d..c8b74980dbd1 100644
> --- a/drivers/vdpa/solidrun/snet_main.c
> +++ b/drivers/vdpa/solidrun/snet_main.c
> @@ -555,7 +555,7 @@ static const struct vdpa_config_ops snet_config_ops = {
>  
>  static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>  {
> -	char name[50];
> +	char *name;
>  	int ret, i, mask = 0;
>  	/* We don't know which BAR will be used to communicate..
>  	 * We will map every bar with len > 0.
> @@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>  		return -ENODEV;
>  	}
>  
> -	snprintf(name, sizeof(name), "psnet[%s]-bars", pci_name(pdev));
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
> +	if (!name)
> +		return -ENOMEM;
> +
>  	ret = pcim_iomap_regions(pdev, mask, name);
>  	if (ret) {
>  		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
> @@ -590,10 +593,13 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
>  
>  static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
>  {
> -	char name[50];
> +	char *name;
>  	int ret;
>  
> -	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "snet[%s]-bars", pci_name(pdev));
> +	if (!name)
> +		return -ENOMEM;
> +
>  	/* Request and map BAR */
>  	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
>  	if (ret) {
> -- 
> 2.46.0


