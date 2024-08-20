Return-Path: <linux-fpga+bounces-620-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED47958098
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Aug 2024 10:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D77A1F21FFB
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Aug 2024 08:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E6D18A6D1;
	Tue, 20 Aug 2024 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2rU0y1S"
X-Original-To: linux-fpga@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1EA189BBD
	for <linux-fpga@vger.kernel.org>; Tue, 20 Aug 2024 08:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724141388; cv=none; b=JS8eXCUvYGDMqZvg/xoNW+w+XKYJg1BZqnvrsD6vNeQWCs8zDDh/WKUtjHk0AjVvNi0lS0pJFTm5jfsp/HZSP4ie90AXs/mc+niiUTtOR2Ag2qasuHMaEyErjIiB67u4vP2hDmIg3udOXvrmTLDdz8IZ9eisC4mOFSMu20pcCQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724141388; c=relaxed/simple;
	bh=DLZKg/oGENcvx3g7vLmJ6PWU9gpxjKwySy5I9EoT3Ow=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=epPfh/1lkFC3lAOQ8fW+iq49yD9eviVQ6zHYtUtAsGZb6ZahipeIMpOU9Ui7yJsFCk01v/gvKMRqT9XgLbDSLWM0HiwcnUsGCysvLcsx5LjhCcIf0CkYKEzcPGUSjpDd4gQH24osesYt3Vl6JQAOVw6KZXAkDY9YBtDwzyfgkrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A2rU0y1S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724141384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pczNxSocdM26pcn5q5hEVOERw14zQBRp0K6rH/Gt/U8=;
	b=A2rU0y1SdX1bWxMLlcdgZNnTzjNeH+7VRstlEdQWvwqfafZEFaUm6UxEK5O39EPKN8UKR2
	Ds63jEXgQLcmMtH5UdDytYOjQf9Kq5No7MQky9R8GCdWaj5Iwp8F1c717wJHo1rC4sumdF
	SYhw1ELSzHQu/2rhu32+xEqJ6v4+FdE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-HZftVaO5Ow2KoK8df03oFA-1; Tue, 20 Aug 2024 04:09:42 -0400
X-MC-Unique: HZftVaO5Ow2KoK8df03oFA-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2f3f0ac6956so226221fa.2
        for <linux-fpga@vger.kernel.org>; Tue, 20 Aug 2024 01:09:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724141381; x=1724746181;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pczNxSocdM26pcn5q5hEVOERw14zQBRp0K6rH/Gt/U8=;
        b=G3gyBIn7ImXHdO/SdQLsT3dqRbcHRcpP7qo4e9sMKXut1hkRtIn2hmH3jCqEpwpzuP
         O0IGq0j2Iv9q9ZaZAmHvFU69wYczDHRWBKEzTfxNK1BloXW/k5L68EhW7Yhh98oyWlVC
         4z1oN5+FYksW4MRqULwFvkGFS9CCdWAFPNwGBLI5k31ANbMPjVKyjGnQszgtlgMYgtoY
         xDuI1/lHm94bNclc/YswDqs/ek6wwk30+f1e8n8K8tLpLz0rKJN/AbWlT8tLPQvpRqBv
         pDY3C6v46bvCdTk8H9zVcGUDOc4CPq1NkBwrMFYUypNoiSJUKhWWGc4MTuQ8UMgK9mIZ
         FGeg==
X-Forwarded-Encrypted: i=1; AJvYcCWCnzTJFBiDqcEyCDFuorqKmO5G3pxzsFzZ4/j3LoD00ESUMf/KldDPIT3cAzi34vi7mNHKSETS2Goc@vger.kernel.org
X-Gm-Message-State: AOJu0YylEJR2/vD5brgj4HYjhhhIlCi2P6hj1+nPkRvSrK9FvUvLXmMZ
	gLIfkZXEGFjnaD997pgFvg2esb0eSuQuuRHJWlv31P1gFLilLSp6vzi1SrZrFT/bOowjToGGm0Z
	zHTQzIup+7b/7bZyIVjJumNIzxMrcxE7el1Kda4CnaLoE0PaydCkpjOpU0gI=
X-Received: by 2002:a05:651c:2211:b0:2ef:24a9:6aa8 with SMTP id 38308e7fff4ca-2f3be3e14b8mr44110271fa.0.1724141380714;
        Tue, 20 Aug 2024 01:09:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUKjHSOAziZ7PYgWrAVl4EdFwjiCRVXWWzixF1wxqW29HSPOlA0o0CuaPTeGWaikDKakA/tA==
X-Received: by 2002:a05:651c:2211:b0:2ef:24a9:6aa8 with SMTP id 38308e7fff4ca-2f3be3e14b8mr44109861fa.0.1724141380001;
        Tue, 20 Aug 2024 01:09:40 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dcc:1f00:bec1:681e:45eb:77e2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383935909sm728451466b.112.2024.08.20.01.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 01:09:39 -0700 (PDT)
Message-ID: <3e4288bb7300f3fd0883ff07b75ae69d0532019b.camel@redhat.com>
Subject: Re: [PATCH 8/9] vdap: solidrun: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, onathan Corbet
 <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Mark
 Brown <broonie@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-fpga@vger.kernel.org, 
 linux-gpio@vger.kernel.org, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Tue, 20 Aug 2024 10:09:37 +0200
In-Reply-To: <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
References: <20240819165148.58201-2-pstanner@redhat.com>
	 <20240819165148.58201-10-pstanner@redhat.com>
	 <74e9109a-ac59-49e2-9b1d-d825c9c9f891@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-19 at 20:19 +0200, Christophe JAILLET wrote:
> Le 19/08/2024 =C3=A0 18:51, Philipp Stanner a =C3=A9crit=C2=A0:
> > solidrun utilizes pcim_iomap_regions(), which has been deprecated
> > by the
> > PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
> > things because it forces usage of quite a complicated bitmask
> > mechanism.
> > The bitmask handling code can entirely be removed by replacing
> > pcim_iomap_regions() and pcim_iomap_table().
> >=20
> > Replace pcim_iomap_regions() and pcim_iomap_table() with
> > pci_iomap_region().
> >=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0 drivers/vdpa/solidrun/snet_main.c | 47 +++++++++++--------------=
-
> > -----
> > =C2=A0 1 file changed, 16 insertions(+), 31 deletions(-)
> >=20
> > diff --git a/drivers/vdpa/solidrun/snet_main.c
> > b/drivers/vdpa/solidrun/snet_main.c
> > index 99428a04068d..abf027ca35e1 100644
> > --- a/drivers/vdpa/solidrun/snet_main.c
> > +++ b/drivers/vdpa/solidrun/snet_main.c
> > @@ -556,33 +556,24 @@ static const struct vdpa_config_ops
> > snet_config_ops =3D {
> > =C2=A0 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet
> > *psnet)
> > =C2=A0 {
> > =C2=A0=C2=A0	char name[50];
> > -	int ret, i, mask =3D 0;
> > +	int i;
> > +
> > +	snprintf(name, sizeof(name), "psnet[%s]-bars",
> > pci_name(pdev));
> > +
> > =C2=A0=C2=A0	/* We don't know which BAR will be used to communicate..
> > =C2=A0=C2=A0	 * We will map every bar with len > 0.
> > =C2=A0=C2=A0	 *
> > =C2=A0=C2=A0	 * Later, we will discover the BAR and unmap all other
> > BARs.
> > =C2=A0=C2=A0	 */
> > =C2=A0=C2=A0	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -		if (pci_resource_len(pdev, i))
> > -			mask |=3D (1 << i);
> > -	}
> > -
> > -	/* No BAR can be used.. */
> > -	if (!mask) {
> > -		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
> > -		return -ENODEV;
> > -	}
> > -
> > -	snprintf(name, sizeof(name), "psnet[%s]-bars",
> > pci_name(pdev));
> > -	ret =3D pcim_iomap_regions(pdev, mask, name);
> > -	if (ret) {
> > -		SNET_ERR(pdev, "Failed to request and map PCI
> > BARs\n");
> > -		return ret;
> > -	}
> > +		if (pci_resource_len(pdev, i)) {
> > +			psnet->bars[i] =3D pcim_iomap_region(pdev,
> > i, name);
>=20
> Hi,
>=20
> Unrelated to the patch, but is is safe to have 'name' be on the
> stack?
>=20
> pcim_iomap_region()
> --> __pcim_request_region()
> --> __pcim_request_region_range()
> --> request_region() or __request_mem_region()
> --> __request_region()
> --> __request_region_locked()
> --> res->name =3D name;
>=20
> So an address on the stack ends in the 'name' field of a "struct
> resource".

Oh oh...

>=20
> According to a few grep, it looks really unusual.
>=20
> I don't know if it is used, but it looks strange to me.


I have seen it used in the kernel ringbuffer log when you try to
request something that's already owned. I think it's here, right in
__request_region_locked():

/*
 * mm/hmm.c reserves physical addresses which then
 * become unavailable to other users.  Conflicts are
 * not expected.  Warn to aid debugging if encountered.
 */
if (conflict->desc =3D=3D IORES_DESC_DEVICE_PRIVATE_MEMORY) {
	pr_warn("Unaddressable device %s %pR conflicts with %pR",
		conflict->name, conflict, res);
}


Assuming I interpret the code correctly:
The conflicting resource is found when a new caller (e.g. another
driver) tries to get the same region. So conflict->name on the original
requester's stack is by now gone and you do get UB.

Very unlikely UB, since only rarely drivers race for the same resource,
but still UB.

But there's also a few other places. Grep for "conflict->name".

>=20
>=20
> If it is an issue, it was apparently already there before this patch.

I think this has to be fixed.

Question would just be whether one wants to fix it locally in this
driver, or prevent it from happening globally by making the common
infrastructure copy the string.


P.


>=20
> > +			if (IS_ERR(psnet->bars[i])) {
> > +				SNET_ERR(pdev, "Failed to request
> > and map PCI BARs\n");
> > +				return PTR_ERR(psnet->bars[i]);
> > +			}
> > +		}
> > =C2=A0=20
> > -	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -		if (mask & (1 << i))
> > -			psnet->bars[i] =3D
> > pcim_iomap_table(pdev)[i];
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > =C2=A0=C2=A0	return 0;
> > @@ -591,18 +582,15 @@ static int psnet_open_pf_bar(struct pci_dev
> > *pdev, struct psnet *psnet)
> > =C2=A0 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet
> > *snet)
> > =C2=A0 {
> > =C2=A0=C2=A0	char name[50];
> > -	int ret;
> > =C2=A0=20
> > =C2=A0=C2=A0	snprintf(name, sizeof(name), "snet[%s]-bar",
> > pci_name(pdev));
> > =C2=A0=C2=A0	/* Request and map BAR */
> > -	ret =3D pcim_iomap_regions(pdev, BIT(snet->psnet-
> > >cfg.vf_bar), name);
> > -	if (ret) {
> > +	snet->bar =3D pcim_iomap_region(pdev, snet->psnet-
> > >cfg.vf_bar, name);
>=20
> Same
>=20
> Just my 2c.
>=20
> CJ
>=20
> > +	if (IS_ERR(snet->bar)) {
> > =C2=A0=C2=A0		SNET_ERR(pdev, "Failed to request and map PCI BAR
> > for a VF\n");
> > -		return ret;
> > +		return PTR_ERR(snet->bar);
> > =C2=A0=C2=A0	}
> > =C2=A0=20
> > -	snet->bar =3D pcim_iomap_table(pdev)[snet->psnet-
> > >cfg.vf_bar];
> > -
> > =C2=A0=C2=A0	return 0;
> > =C2=A0 }
> > =C2=A0=20
> > @@ -650,15 +638,12 @@ static int psnet_detect_bar(struct psnet
> > *psnet, u32 off)
> > =C2=A0=20
> > =C2=A0 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct
> > psnet *psnet)
> > =C2=A0 {
> > -	int i, mask =3D 0;
> > +	int i;
> > =C2=A0=20
> > =C2=A0=C2=A0	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > =C2=A0=C2=A0		if (psnet->bars[i] && i !=3D psnet->barno)
> > -			mask |=3D (1 << i);
> > +			pcim_iounmap_region(pdev, i);
> > =C2=A0=C2=A0	}
> > -
> > -	if (mask)
> > -		pcim_iounmap_regions(pdev, mask);
> > =C2=A0 }
> > =C2=A0=20
> > =C2=A0 /* Read SNET config from PCI BAR */
>=20
>=20


