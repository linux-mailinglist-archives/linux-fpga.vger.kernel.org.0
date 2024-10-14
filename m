Return-Path: <linux-fpga+bounces-774-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355A499CADC
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Oct 2024 14:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E97AE283F34
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Oct 2024 12:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5211AA78B;
	Mon, 14 Oct 2024 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LWIqtBy4"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED95A1E4A6
	for <linux-fpga@vger.kernel.org>; Mon, 14 Oct 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728910768; cv=none; b=Ct7epKhznZx5vmgjAp/QYelF8bBaHqppGE2fXhO8CS4gp03WpWNLQ2VCRwfiXNeBLiRqn8Otit5KJyZjDOOnU5zpFLwpvPmOxOipP9L58qfHQ5CUqaEMhub0aQuJnkuA/CPfdh9O1QeZG8e7Bp787sNITyE9IITw5tzIjj8uIP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728910768; c=relaxed/simple;
	bh=Jg6pGOYiv5OzHtrcu0KE602yPfdGSrud2Mdl8UCB5Ug=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I5q16MpiQNNWoyStK08Bt0pjyinnMk1N7IjPd1AJePFgRZyvSKOrvvrK/BQhtacqviYlnf8v4pGfFhdpll0wKa4HZ6Cc/V8uYpfRlfCjW+mkmPKi/jJti/nLzR2EhlNWc0VvV+Hh8ZuVJoElIqboAcBoRYUZiYVLVdp7E5Px0cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LWIqtBy4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728910765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kbvknu1cOjZZ0csG9pJAkO2ZJHMWQOgShZkt8KNqc3E=;
	b=LWIqtBy4J6mj2g4pFzNddAJGHmWlfbzNExuCNSWIZ0ELvmrvoTz3lbwik1XjS5cnrt/p7N
	+l/Q3Df+0OGTvx7JWSg3X8na5m5UBsf3Gy3GaUiUzy/Et1a1aanFaDKxbIyG3bosQweDIa
	qpVs0lS1iExP1aaC2bcD94740Sck5KA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-935COlyMOE2JVkxJ9P_M2g-1; Mon, 14 Oct 2024 08:59:22 -0400
X-MC-Unique: 935COlyMOE2JVkxJ9P_M2g-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c937403b2bso2879807a12.1
        for <linux-fpga@vger.kernel.org>; Mon, 14 Oct 2024 05:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728910761; x=1729515561;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kbvknu1cOjZZ0csG9pJAkO2ZJHMWQOgShZkt8KNqc3E=;
        b=Ykr4/97uz2WzQCUIX08VujEFIZJ3oQETAd3lHVGBHb6/6TzJLWoR8BIYPYpqqQPhbo
         D3ao8WXDBjhV2XwhAC8DGTo+Ocd4DLa/s58BhoEhBETYRQYK/YV7b4RMaODmxR6kVArT
         QWARkw73we1cxDQUGnMr/Ka+4JBeNYIr02I2b7RIH/OcPKo1nWmWQv07z8uFm1++ghSA
         LD+pW5rO3QwKH/o5uPYjvVr01f/OSqYQ7MuGX5VKopqI4t3ONmpcoHjDRZWzf12+y7Xd
         +KezLO8xnBrt2A2/l54UoQZCS5fwEH48lhJWHjzFy1o2Wr8Tlul9AslCfUCTLnAG8WCl
         vCmw==
X-Forwarded-Encrypted: i=1; AJvYcCXNqSoisK8TbyPjiT+7et+HHTK+VkMLnvbI5BbJBRqxGkRdTVvADETQrPR4FxAiWYQGdS/vQDCjIc0R@vger.kernel.org
X-Gm-Message-State: AOJu0YwsZ/hXQ6bucKYrCD0s7473JunaHhrt+pdW9OQdluwuVlqvveud
	3RdiGpUnMpKBU4SLT2+esXSiZCaVMx4jACRDApExdCVb0lHzhHR6ocTwMRM7Icox9E50JviZ3aE
	XV4yh1HythUxoTjM5B795fJ0e0cmyrCRrCKtwB84zb6kxtNhmqBTAYuzxA7c=
X-Received: by 2002:a05:6402:2114:b0:5c9:6b7f:2f16 with SMTP id 4fb4d7f45d1cf-5c96b7f3145mr4416879a12.18.1728910761574;
        Mon, 14 Oct 2024 05:59:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFF+8Ta6ohQ9/nfR6Qe62tH/JkmiX/F4n9q/mR7oEx4wYYvRcjJ5zg08dI/qWotLZ1mqCX6w==
X-Received: by 2002:a05:6402:2114:b0:5c9:6b7f:2f16 with SMTP id 4fb4d7f45d1cf-5c96b7f3145mr4416852a12.18.1728910761078;
        Mon, 14 Oct 2024 05:59:21 -0700 (PDT)
Received: from ?IPv6:2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3? (200116b82d3798001d5778cfc1aeb0b3.dip.versatel-1u1.de. [2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c937267272sm4966512a12.75.2024.10.14.05.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 05:59:20 -0700 (PDT)
Message-ID: <ae39d2783db4ecadd69a7e85d92ebe45c626bd62.camel@redhat.com>
Subject: Re: [PATCH v7 4/5] gpio: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Richard Cochran <richardcochran@gmail.com>, Damien
 Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Al Viro
 <viro@zeniv.linux.org.uk>,  Keith Busch <kbusch@kernel.org>, Li Zetao
 <lizetao1@huawei.com>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org,  Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>
Date: Mon, 14 Oct 2024 14:59:17 +0200
In-Reply-To: <20241014121324.GT77519@kernel.org>
References: <20241014075329.10400-1-pstanner@redhat.com>
	 <20241014075329.10400-5-pstanner@redhat.com>
	 <20241014121324.GT77519@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-10-14 at 13:13 +0100, Simon Horman wrote:
> On Mon, Oct 14, 2024 at 09:53:25AM +0200, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the
> > PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace those functions with calls to pcim_iomap_region().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > =C2=A0drivers/gpio/gpio-merrifield.c | 14 +++++++-------
> > =C2=A01 file changed, 7 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-
> > merrifield.c
> > index 421d7e3a6c66..274afcba31e6 100644
> > --- a/drivers/gpio/gpio-merrifield.c
> > +++ b/drivers/gpio/gpio-merrifield.c
> > @@ -78,24 +78,24 @@ static int mrfld_gpio_probe(struct pci_dev
> > *pdev, const struct pci_device_id *id
> > =C2=A0	if (retval)
> > =C2=A0		return retval;
> > =C2=A0
> > -	retval =3D pcim_iomap_regions(pdev, BIT(1) | BIT(0),
> > pci_name(pdev));
> > -	if (retval)
> > -		return dev_err_probe(dev, retval, "I/O memory
> > mapping error\n");
> > -
> > -	base =3D pcim_iomap_table(pdev)[1];
> > +	base =3D pcim_iomap_region(pdev, 1, pci_name(pdev));
> > +	if (IS_ERR(base))
> > +		return dev_err_probe(dev, PTR_ERR(base), "I/O
> > memory mapping error\n");
> > =C2=A0
> > =C2=A0	irq_base =3D readl(base + 0 * sizeof(u32));
> > =C2=A0	gpio_base =3D readl(base + 1 * sizeof(u32));
> > =C2=A0
> > =C2=A0	/* Release the IO mapping, since we already get the info
> > from BAR1 */
> > -	pcim_iounmap_regions(pdev, BIT(1));
> > +	pcim_iounmap_region(pdev, 1);
> > =C2=A0
> > =C2=A0	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > =C2=A0	if (!priv)
> > =C2=A0		return -ENOMEM;
> > =C2=A0
> > =C2=A0	priv->dev =3D dev;
> > -	priv->reg_base =3D pcim_iomap_table(pdev)[0];
> > +	priv->reg_base =3D pcim_iomap_region(pdev, 0,
> > pci_name(pdev));
> > +	if (IS_ERR(priv->reg_base))
> > +		return dev_err_probe(dev, PTR_ERR(base), "I/O
> > memory mapping error\n");
>=20
> Hi Philipp,
>=20
> There seems to be a mismatch in the use of priv->reg_base and base
> above.
> Should the above use PTR_ERR(priv->reg_base) instead of
> PTR_ERR(base)?

uff, yes, good catch!
Will fix, thx

P.

>=20
> > =C2=A0
> > =C2=A0	priv->pin_info.pin_ranges =3D mrfld_gpio_ranges;
> > =C2=A0	priv->pin_info.nranges =3D ARRAY_SIZE(mrfld_gpio_ranges);
> > --=20
> > 2.46.2
> >=20
> >=20
>=20


