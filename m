Return-Path: <linux-fpga+bounces-628-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA4D958587
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Aug 2024 13:14:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD0E8B2270F
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Aug 2024 11:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5A118DF9A;
	Tue, 20 Aug 2024 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZxUgMxig"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B5C18DF9F
	for <linux-fpga@vger.kernel.org>; Tue, 20 Aug 2024 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152470; cv=none; b=uCmT2JjC9coqH3/x2JgDsv6fnxFLmlPs5NVfWfAB02X/o8JtfabgEEPubQD2eyp+gfRoV7xBWZl56qu+ydAU03O0rXczJuQ9M2n2XywMHG5b8DCbpZAqT7Fo4UEszvuC+QNA1eEh6Mrj4TFHjR+E4+AiS51sqLgw7n5Jk6hZKPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152470; c=relaxed/simple;
	bh=rGM+Q7dIYBoJCsuGamvXSRRNj+I6b8oz5K4/Bniwl6c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W7g7YkSrNdOB1ct2OeYct9ubVD9YcNtUWkHmKZFNvDWB+Wt/TQSHWoMUh83Pmv2UO0NbMUVYdyf4dj1lZLI4s8Lf5c3Fp101ErrAEW0X61w2BFYx5npnBW+etBBERUOqkJSokr429iK1DRKmk5NSMDvqISlnPYy6vx8ZdZntk/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZxUgMxig; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724152466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1Q7acyOuQZwg2/89j6b8m+Ec7sRWq6gAjTgotRXIu4=;
	b=ZxUgMxigcL28KDb3lX8zt3On+TqIFWKB94LNJd/ZouekxfNkzCxT9Y4FtUYPTnmzmbMD3Y
	U4vuUad4yE7aGseWvZSIBXoZTu5nJ69l05m/xnIJj6YCD894h/bQVUCQOsmofNNtML9ctG
	3Fdn9rW5MfEb51OVbCJiFTMv6AjJs5Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-o40Ic-9bN_Kt35QLZ1PMqQ-1; Tue, 20 Aug 2024 07:14:24 -0400
X-MC-Unique: o40Ic-9bN_Kt35QLZ1PMqQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-532ffe05314so547568e87.2
        for <linux-fpga@vger.kernel.org>; Tue, 20 Aug 2024 04:14:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152463; x=1724757263;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1Q7acyOuQZwg2/89j6b8m+Ec7sRWq6gAjTgotRXIu4=;
        b=Oqee8Zx+wf3ynxPBU86GiHj2AIKlD37SFmlsKVmNZh2D3ONlG4GOKQVcwJOGF2gCl4
         mUWnRK4ueG311Y2AgicxW7PIvIh5v+Dg+1h/UeYGwJAdFQrVoTBPNjTl6o6f6MKngRVI
         Slx65C2v/ANExVVrDU290cNOla+IOa4yQ+SkAurovDDVDAFYu18qBF7t3FMNAqQEIX+k
         RDRCa85N8tmIL7nRK51BaXUkoHkcZoMI5NYhFRx2XjIn9MCaGnkCPREBPiAM9crhxx2r
         ATIyBDdtVZNttrFIcf/NNrumoxKqkIQOKcXbW8NqcQeVX+djOUwdJ5Wckegk3bfk1VYa
         4Avg==
X-Forwarded-Encrypted: i=1; AJvYcCVI8wVOZm856iE5Fnv2tgZ23OoMikRcwzXgzljptaXfdcTGZOgFAfX2JGtnl6wZDHsONuXeWBM7baMoK0mdpc/iLK2+lbA+uyyaZQ==
X-Gm-Message-State: AOJu0YzTOspVBJnU6Zy4d4+nNEwEz/jvZYjMOMVm81NKOmdJn2jitYEm
	3gznEt2BEv7dNfrH1YhvtljJc7PMBNKBIdPdWbHm6vuuT5Dc5II21WB6qrKqECeUc22XBpienjF
	BDGlzvlAu6X6IadjiEQdOjfoaFhwFFtAikOhThbh2+O93y2ZbOeHl4H5JcQI=
X-Received: by 2002:a05:6512:3c84:b0:530:baec:3975 with SMTP id 2adb3069b0e04-5331c6904bamr5596046e87.1.1724152463000;
        Tue, 20 Aug 2024 04:14:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYdlvki0skRqSH7C03GeJxZqEQK+y/koEXnizdbc6P1v4DyVRhp4tYp6FmBEQj38Z0lN9WKg==
X-Received: by 2002:a05:6512:3c84:b0:530:baec:3975 with SMTP id 2adb3069b0e04-5331c6904bamr5596024e87.1.1724152462340;
        Tue, 20 Aug 2024 04:14:22 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935657sm747366866b.138.2024.08.20.04.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:14:22 -0700 (PDT)
Message-ID: <01b1e7d505a2b3e670f1613ce3e6a60efd3449ab.camel@redhat.com>
Subject: Re: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: alexandre.torgue@foss.st.com, alvaro.karsz@solid-run.com,
 andy@kernel.org,  axboe@kernel.dk, bhelgaas@google.com, brgl@bgdev.pl,
 broonie@kernel.org,  corbet@lwn.net, davem@davemloft.net,
 edumazet@google.com, eperezma@redhat.com,  hao.wu@intel.com,
 jasowang@redhat.com, joabreu@synopsys.com, kuba@kernel.org, 
 linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-block@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com, 
 mdf@kernel.org, mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, 
 richardcochran@gmail.com, trix@redhat.com, virtualization@lists.linux.dev, 
 xuanzhuo@linux.alibaba.com, yilun.xu@intel.com
Date: Tue, 20 Aug 2024 13:14:20 +0200
In-Reply-To: <d35a962d-dc95-4469-867e-95b704cca474@wanadoo.fr>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-10-pstanner@redhat.com>
	 <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
	 <3e4288bb7300f3fd0883ff07b75ae69d0532019b.camel@redhat.com>
	 <d35a962d-dc95-4469-867e-95b704cca474@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-20 at 12:50 +0200, Christophe JAILLET wrote:
> Le 20/08/2024 =C3=A0 10:09, Philipp Stanner a =C3=A9crit=C2=A0:
> > > > @@ -556,33 +556,24 @@ static const struct vdpa_config_ops
> > > > snet_config_ops =3D {
> > > > =C2=A0=C2=A0 static int psnet_open_pf_bar(struct pci_dev *pdev, str=
uct
> > > > psnet
> > > > *psnet)
> > > > =C2=A0=C2=A0 {
> > > > =C2=A0=C2=A0=C2=A0	char name[50];
> > > > -	int ret, i, mask =3D 0;
> > > > +	int i;
> > > > +
> > > > +	snprintf(name, sizeof(name), "psnet[%s]-bars",
> > > > pci_name(pdev));
> > > > +
> > > > =C2=A0=C2=A0=C2=A0	/* We don't know which BAR will be used to
> > > > communicate..
> > > > =C2=A0=C2=A0=C2=A0	 * We will map every bar with len > 0.
> > > > =C2=A0=C2=A0=C2=A0	 *
> > > > =C2=A0=C2=A0=C2=A0	 * Later, we will discover the BAR and unmap all=
 other
> > > > BARs.
> > > > =C2=A0=C2=A0=C2=A0	 */
> > > > =C2=A0=C2=A0=C2=A0	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > > > -		if (pci_resource_len(pdev, i))
> > > > -			mask |=3D (1 << i);
> > > > -	}
> > > > -
> > > > -	/* No BAR can be used.. */
> > > > -	if (!mask) {
> > > > -		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> > > > -		return -ENODEV;
> > > > -	}
> > > > -
> > > > -	snprintf(name, sizeof(name), "psnet[%s]-bars",
> > > > pci_name(pdev));
> > > > -	ret =3D pcim_iomap_regions(pdev, mask, name);
> > > > -	if (ret) {
> > > > -		SNET_ERR(pdev, "Failed to request and map PCI
> > > > BARs\n");
> > > > -		return ret;
> > > > -	}
> > > > +		if (pci_resource_len(pdev, i)) {
> > > > +			psnet->bars[i] =3D
> > > > pcim_iomap_region(pdev,
> > > > i, name);
> > >=20
> > > Hi,
> > >=20
> > > Unrelated to the patch, but is is safe to have 'name' be on the
> > > stack?
> > >=20
> > > pcim_iomap_region()
> > > --> __pcim_request_region()
> > > --> __pcim_request_region_range()
> > > --> request_region() or __request_mem_region()
> > > --> __request_region()
> > > --> __request_region_locked()
> > > --> res->name =3D name;
> > >=20
> > > So an address on the stack ends in the 'name' field of a "struct
> > > resource".
> >=20
> > Oh oh...
> >=20
> > >=20
> > > According to a few grep, it looks really unusual.
> > >=20
> > > I don't know if it is used, but it looks strange to me.
> >=20
> >=20
> > I have seen it used in the kernel ringbuffer log when you try to
> > request something that's already owned. I think it's here, right in
> > __request_region_locked():
> >=20
> > /*
> > =C2=A0 * mm/hmm.c reserves physical addresses which then
> > =C2=A0 * become unavailable to other users.=C2=A0 Conflicts are
> > =C2=A0 * not expected.=C2=A0 Warn to aid debugging if encountered.
> > =C2=A0 */
> > if (conflict->desc =3D=3D IORES_DESC_DEVICE_PRIVATE_MEMORY) {
> > 	pr_warn("Unaddressable device %s %pR conflicts with %pR",
> > 		conflict->name, conflict, res);
> > }
> >=20
> >=20
> > Assuming I interpret the code correctly:
> > The conflicting resource is found when a new caller (e.g. another
> > driver) tries to get the same region. So conflict->name on the
> > original
> > requester's stack is by now gone and you do get UB.
> >=20
> > Very unlikely UB, since only rarely drivers race for the same
> > resource,
> > but still UB.
> >=20
> > But there's also a few other places. Grep for "conflict->name".
> >=20
> > >=20
> > >=20
> > > If it is an issue, it was apparently already there before this
> > > patch.
> >=20
> > I think this has to be fixed.
> >=20
> > Question would just be whether one wants to fix it locally in this
> > driver, or prevent it from happening globally by making the common
> > infrastructure copy the string.
> >=20
> >=20
> > P.
> >=20
>=20
> Not a perfect script, but the below coccinelle script only find this=20
> place, so I would +1 only fixing things here only.
>=20
> Agree?

Yup, sounds good. Copying the string would cause trouble (GFP flags)
anyways.

I'll provide a fix in v2.

Thanks,
P.

>=20
> CJ
>=20
>=20
>=20
> @@
> identifier name;
> expression x;
> constant N;
> @@
> 	char name[N];
> 	...
> (
> *	pcim_iomap_region(..., name, ...);
> >=20
> *	pcim_iomap_regions(..., name, ...);
> >=20
> *	request_region(..., name, ...);
> >=20
> *	x =3D pcim_iomap_region(..., name, ...);
> >=20
> *	x =3D pcim_iomap_regions(..., name, ...);
> >=20
> *	x =3D request_region(..., name, ...);
> )
>=20
>=20


