Return-Path: <linux-fpga+bounces-667-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A4095F465
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Aug 2024 16:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51544B212A7
	for <lists+linux-fpga@lfdr.de>; Mon, 26 Aug 2024 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088781917E0;
	Mon, 26 Aug 2024 14:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bA4lXiLw"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3718D64D
	for <linux-fpga@vger.kernel.org>; Mon, 26 Aug 2024 14:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683874; cv=none; b=ASvSTrt3/xmcomQHmJH3w78DA9CQBxD5r2BmDgc4ZoLCgrvQcEb6U18xgxBrI5OBWuXaswLCRlW34tuGOgGV1YvQqrabyvLGOtlfN0JradNKaILXUZn3qbRlZbhxdZjIKjGdm+MBGyQ2RSOHJyeHyuHHulnq6JQ0HkH9jEMWZgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683874; c=relaxed/simple;
	bh=gejqF3lxPDzVKaKWaPqTWU5CZhdrvtg8FR6CXRKXq10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OZTOhFM6niFVUb8gndkySFQ7mHAdTH8acRsKHwb1fdwPlVkfu4bYbwzw8s29dt21sX55rv4w1ZoM13as8GsQj1sjR0fnYhV2Xi79wuNu2CrA86l3jsKi+nibbOx7SQ7IOQBkdkIMnWpXsOtXelRiiAnC9UtXNUT0frBi5Qe4Pok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bA4lXiLw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724683872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ygoQZIsbD2qBAAmAvknxBdRGvmvE0QFAtlIfXcqGyiA=;
	b=bA4lXiLwLbxXH+chWnqogx2r3zeNyU2BAG7EXKp0TAbr+VgsMWZrBFK2X/vjyQYNAordpb
	CTrrECbjWibCTvnGfb9rOHN71bKIAo0heafCSIVLe3Rv8fGO0xWQ0+w+7D28s7wqXVj62g
	mQeEYjSsXNqTmBUSuwenOPOEb5sO+zE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Dycc5qLbODu_XvF26EG6Iw-1; Mon, 26 Aug 2024 10:51:11 -0400
X-MC-Unique: Dycc5qLbODu_XvF26EG6Iw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3718ce3f6bdso3241555f8f.2
        for <linux-fpga@vger.kernel.org>; Mon, 26 Aug 2024 07:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724683870; x=1725288670;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ygoQZIsbD2qBAAmAvknxBdRGvmvE0QFAtlIfXcqGyiA=;
        b=fGxkqXyXxByYFjgDETnkQ2BK5j5dEwI2H0acNbsFCCZe6TznQGespWibI1ZfAwOA51
         un6NP/fV0QqjohRh/OD9Yf9CQi6PMHY1Jdykz53Iz9ulZ36APCCzY9blpiWIco7HfGkb
         4tftsWG8g88Sr4jfM1J1XPAYw1iDR0qqFCE0nQ9oLKlXXpt8GrL45opUPQ8uhQ1JzdFZ
         RqNblBF4ueHJIUwNB3j7/P2TVcwGiGW2Yu1llcqFDQGbfay+TdHZmVvy1LHy+y4+pB7V
         y/jC6k9dd9cq3/2dO8NC+3kK3BGY4USRwFjjPgeLKFhV5Kuft1UmXfiB2ECSeQCvCw4y
         HYZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaii0TmmWxb4CTOI1+mEm4iNPOMxDXTus7OCuJKR/cJRINVx4ri8+9UIHc88mw8G3KD7tZhAIdJtCM@vger.kernel.org
X-Gm-Message-State: AOJu0YxRV1ODHhfZMS8QaUYJiIetzUvR4TpdAwdF5T5AyRzlP/YClXrK
	CUelCzOQsetZGpmiEC31mdTvxuW8C2vtjr8zWR8++FGANk5cHgPV9XoT0tt0ohuFU3FkNV7OhEK
	Ev5lBmFYaHuLYI/P9MoFYByeL673sOzU2IVWIOtb8hZALhxO92Z3k6//rKWs=
X-Received: by 2002:a05:6000:18a4:b0:369:b842:5065 with SMTP id ffacd0b85a97d-373118c853bmr9315232f8f.41.1724683869832;
        Mon, 26 Aug 2024 07:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzcbeZGAiG9pR7gwgPFjZ9tQkwyQH6hKqQkC/ZviQjFl3Zuqsn+yKqro2WkBtRVRH4FkIJWQ==
X-Received: by 2002:a05:6000:18a4:b0:369:b842:5065 with SMTP id ffacd0b85a97d-373118c853bmr9315196f8f.41.1724683869319;
        Mon, 26 Aug 2024 07:51:09 -0700 (PDT)
Received: from dhcp-64-164.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373082096bbsm10889215f8f.89.2024.08.26.07.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 07:51:08 -0700 (PDT)
Message-ID: <ad6af1c4194873e803df65dc4d595f8e4b26cb33.camel@redhat.com>
Subject: Re: [PATCH v3 5/9] ethernet: cavium: Replace deprecated PCI
 functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao
 <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, Moritz Fischer
 <mdf@kernel.org>,  Xu Yilun <yilun.xu@intel.com>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Mark
 Brown <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Damien Le
 Moal <dlemoal@kernel.org>,  Hannes Reinecke <hare@suse.de>, Chaitanya
 Kulkarni <kch@nvidia.com>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Mon, 26 Aug 2024 16:51:07 +0200
In-Reply-To: <ZsdO2q8uD829hP-X@smile.fi.intel.com>
References: <20240822134744.44919-1-pstanner@redhat.com>
	 <20240822134744.44919-6-pstanner@redhat.com>
	 <ZsdO2q8uD829hP-X@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-22 at 17:44 +0300, Andy Shevchenko wrote:
> On Thu, Aug 22, 2024 at 03:47:37PM +0200, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with the function pcim_iomap_region().
>=20
> ...
>=20
> > -	err =3D pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO,
> > pci_name(pdev));
> > -	if (err)
> > +	clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_BAR_NO,
> > pci_name(pdev));
> > +	if (IS_ERR(clock->reg_base)) {
> > +		err =3D PTR_ERR(clock->reg_base);
> > =C2=A0		goto error_free;
> > -
> > -	clock->reg_base =3D pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
> > +	}
>=20
> Perhaps
>=20
> 	clock->reg_base =3D pcim_iomap_region(pdev, PCI_PTP_BAR_NO,
> pci_name(pdev));
> 	err =3D PTR_ERR_OR_ZERO(clock->reg_base);
> 	if (err)
> 		goto error_free;
>=20
> This will make your patch smaller and neater.
>=20
> P.S. Do you use --histogram diff algo when preparing patches?

So far not.
Should one do that?

P.


>=20


