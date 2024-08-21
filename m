Return-Path: <linux-fpga+bounces-647-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEB5959BC5
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Aug 2024 14:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B46CB24FF0
	for <lists+linux-fpga@lfdr.de>; Wed, 21 Aug 2024 12:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C906D18E34A;
	Wed, 21 Aug 2024 12:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jCwK6FmL"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A007C171E69
	for <linux-fpga@vger.kernel.org>; Wed, 21 Aug 2024 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724243169; cv=none; b=WuAj8OS4Uo1u2DmWH90kduuooCtm/NVk+nKNbn2JMyOhxjtE7Cdg33g0WsILANDsadj2i8HKe/dk0R4AHW5hV3GKFIF1qY9VZdab2zGmN1gL7YDzY7znZ4uAHRrnb4BgkQA5fetzQ/huufA6Ikqon5b4hdmf7zsXrAat7lMEAlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724243169; c=relaxed/simple;
	bh=uuRCWDxDb6ZlmmrDflEcqKb34QjG6BdOf9n0HKg89DY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BgP1HQmC0Trmk5gZrQ+JDqECqM8sJClvtpFjgoqrgFdjgdCC/j7q1wgESHWUwMBr1xcp7FxlkIezVKQeJeIFiArsbKpkaeJpWYPoSqpPrS98OPwBAAV2gYTepz799Lr+4awHPU2F9+hs3fcXr2oSm04jSzVsExtMm4vgMrNBfMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jCwK6FmL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724243165;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+8Zd9p9xEaFFxq9bSwT6CVTjqvDBBcELEezra/NBmQ=;
	b=jCwK6FmLFbchFIo6pYAoaDlK2NYeGNMLwRyRjGg9Bx4wUjfRaR88vmH6sRH2B/pTkxKPLc
	InCKTW5ZTfcy2mXpqgR2oX3QpxPVhcA6i+VQpC3bI84zPOL3/IoAn6infnrCMJaoFvDukn
	wpzrhu4BZg8xhJP2s1WjU0CH0XlM2C4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-AsqKZu3LPUG7RSKRihyXMg-1; Wed, 21 Aug 2024 08:26:04 -0400
X-MC-Unique: AsqKZu3LPUG7RSKRihyXMg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6bf788e4692so61609856d6.2
        for <linux-fpga@vger.kernel.org>; Wed, 21 Aug 2024 05:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724243164; x=1724847964;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+8Zd9p9xEaFFxq9bSwT6CVTjqvDBBcELEezra/NBmQ=;
        b=aEh517NTUZHQBhn8V7ZMaUZnxKb+Gfqj5xhaTTKvxRdGKnLMxxLKLpyGIATyjvAG7b
         zOecHsyu9J4NzpVGhCuNB5idckcnnLxa+uX0R+EjbWzBOTT20RynYwUqF7gq1X9v5Tyw
         1nfdGToYtZOKHJ2NuWWgd9Le0KOaIvPXQgs/oRQ2LW1FEleFnYSvtpNMOsFj7GolQCGA
         7aAkLre0ueJyC0kHyv6Upu1uCSh7dgfTAAWiNxCrNtPIVli3tIgqukfDTmg9Veujsn9m
         kgFPea+gaj8aKLJ6CiMwHSxxWAW6vE5NeRBk/1klc0AscEs9EzeE5AKgRoGuzyNwC7xG
         WEwA==
X-Forwarded-Encrypted: i=1; AJvYcCUxXci0aYhVlMHMD8N1tAtbTNewtdDoeK+AU7eNpORlYh0kgQK8poIJc3WfmLDDK6BKXhTV56o6xDtO@vger.kernel.org
X-Gm-Message-State: AOJu0YzM6WJAA64+iY6aXh400axSnTFR9iSM48A+5EvdYPnXZUE9+/3j
	gWdCXUlsXa+YGVDKzJhtxUhxjlfnCOHAmW+sQyCb4BGl+xEx7TUhzPwJl7NYzQaJXqlMRZW4ycD
	l3FHDE9CDzLwwVZmIdynZ1UiHNGQknSyUpbBpzzvT0laXqzNdGk4txtHL8PA=
X-Received: by 2002:a05:6214:4881:b0:6bf:a721:9945 with SMTP id 6a1803df08f44-6c1567fabf5mr30554816d6.24.1724243163964;
        Wed, 21 Aug 2024 05:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0sBOMGGLa2XcF/yRLMaOTYNrH07fkAWiC1e2c/uh8oASqBZoK+O1goCyf57ZnaX9oaF0YiA==
X-Received: by 2002:a05:6214:4881:b0:6bf:a721:9945 with SMTP id 6a1803df08f44-6c1567fabf5mr30554416d6.24.1724243163535;
        Wed, 21 Aug 2024 05:26:03 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6ff0dcdasm60220946d6.140.2024.08.21.05.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 05:26:03 -0700 (PDT)
Message-ID: <cf9591d720c9b25dafd46b627ff8b6ed9f417745.camel@redhat.com>
Subject: Re: [PATCH v2 7/9] vdpa: solidrun: Fix potential UB bug with devres
From: Philipp Stanner <pstanner@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko
 <andy@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, Alvaro
 Karsz <alvaro.karsz@solid-run.com>, Jason Wang <jasowang@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Mark
 Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Damien Le
 Moal <dlemoal@kernel.org>,  Hannes Reinecke <hare@suse.de>, Keith Busch
 <kbusch@kernel.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev,  stable@vger.kernel.org, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Date: Wed, 21 Aug 2024 14:25:57 +0200
In-Reply-To: <20240821081213-mutt-send-email-mst@kernel.org>
References: <20240821071842.8591-2-pstanner@redhat.com>
	 <20240821071842.8591-9-pstanner@redhat.com>
	 <20240821081213-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-21 at 08:12 -0400, Michael S. Tsirkin wrote:
> On Wed, Aug 21, 2024 at 09:18:40AM +0200, Philipp Stanner wrote:
> > In psnet_open_pf_bar() a string later passed to
> > pcim_iomap_regions() is
> > placed on the stack. Neither pcim_iomap_regions() nor the functions
> > it
> > calls copy that string.
> >=20
> > Should the string later ever be used, this, consequently, causes
> > undefined behavior since the stack frame will by then have
> > disappeared.
> >=20
> > Fix the bug by allocating the string on the heap through
> > devm_kasprintf().
> >=20
> > Cc: stable@vger.kernel.org	# v6.3
> > Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
> > Reported-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > Closes:
> > https://lore.kernel.org/all/74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanado=
o.fr/
> > Suggested-by: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
>=20
> I don't get why is this a part of a cleanup series -
> looks like an unrelated bugfix?

It was discovered in the discussion of v1 of this series.

It indeed is an unrelated bugfix and could be merged separately. But my
patch #8 depends on it.

So it would be convenient to merge it into mainline through this
series, and have stable just pick patch #7.

Or should it be done differently, in your opinion?

P.

>=20
>=20
> > ---
> > =C2=A0drivers/vdpa/solidrun/snet_main.c | 7 +++++--
> > =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > b/drivers/vdpa/solidrun/snet_main.c
> > index 99428a04068d..4d42a05d70fc 100644
> > --- a/drivers/vdpa/solidrun/snet_main.c
> > +++ b/drivers/vdpa/solidrun/snet_main.c
> > @@ -555,7 +555,7 @@ static const struct vdpa_config_ops
> > snet_config_ops =3D {
> > =C2=A0
> > =C2=A0static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
> > *psnet)
> > =C2=A0{
> > -	char name[50];
> > +	char *name;
> > =C2=A0	int ret, i, mask =3D 0;
> > =C2=A0	/* We don't know which BAR will be used to communicate..
> > =C2=A0	 * We will map every bar with len > 0.
> > @@ -573,7 +573,10 @@ static int psnet_open_pf_bar(struct pci_dev
> > *pdev, struct psnet *psnet)
> > =C2=A0		return -ENODEV;
> > =C2=A0	}
> > =C2=A0
> > -	snprintf(name, sizeof(name), "psnet[%s]-bars",
> > pci_name(pdev));
> > +	name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-
> > bars", pci_name(pdev));
> > +	if (!name)
> > +		return -ENOMEM;
> > +
> > =C2=A0	ret =3D pcim_iomap_regions(pdev, mask, name);
> > =C2=A0	if (ret) {
> > =C2=A0		SNET_ERR(pdev, "Failed to request and map PCI
> > BARs\n");
> > --=20
> > 2.46.0
>=20


