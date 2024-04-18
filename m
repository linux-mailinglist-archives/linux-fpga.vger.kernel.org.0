Return-Path: <linux-fpga+bounces-489-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF798A9245
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Apr 2024 07:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47DAA283D88
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Apr 2024 05:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6193254913;
	Thu, 18 Apr 2024 05:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gcNK26F1"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B294282F4
	for <linux-fpga@vger.kernel.org>; Thu, 18 Apr 2024 05:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713416988; cv=none; b=UgyYPxnPotgqFGAA3ZSeMzE78qpcR5xBqrOBz/+Tgkw8FjUJ20ThC3f98wuZDKf6CsFZrRyvynUDcNt2ZU2JjWwQoTa7/tkxW6OidA7Y+sexUMUIy20n6zZYmC6nGuNg5QpSGX3pnAdgQh1AINIqAsmDzmM0jdcImiSxjNeeTkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713416988; c=relaxed/simple;
	bh=Xl16L+W/SEdGUAhJw1Rn++aOtBymjsNvuu10RLRyOgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Phr6VzH89qGj/NEw7ESM00SbXz26owndkh4f/a47QpR+wLqJrei/1BIj26C3Ut1ts8GtxkmkPTpazygFf734gbcYF2lfEb9qZksXfafyLZD/47L+I6OxhT1krJG++JzdgkjME8E7z/Lb9TJ/yCELW1xg7ORMD3DC+ZKP94Kvtbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gcNK26F1; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-5acf5c1a2f5so368530eaf.0
        for <linux-fpga@vger.kernel.org>; Wed, 17 Apr 2024 22:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713416985; x=1714021785; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2YXu3fJhep/jeABuK6lsIeB/c/Qb99q1dRrd86tjx8=;
        b=gcNK26F1OFFf4xrIVQ6SfQ5RKQAdgSOj9+tJtDGvnkseWv7g4yUhM4RfULG7V3giN5
         N8eyUCAP7+4ylImz9ktB32bK7xH6I1PU4R0dlbu0AfeGS1LY2GA9KiF8B/AseUUZoDO0
         PyHmz9azsgM7PYJsMJG/KAuAN+FzlW9ZRwue5YWpZkcjxr791xk44/mEgNF2PqSBO4Si
         qPW8JneHSsg2DsC8P9Kh6mBiGoYiCehenliymqXCre+1Jm7QYjRSYljOlf15UlxNJ9CT
         Diensyi8oefInzGv9k/fsaldG+Ywcu1pZp9nBHqTZBip/7zgSirn3EjWhgBeBokAt7+A
         CZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713416985; x=1714021785;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2YXu3fJhep/jeABuK6lsIeB/c/Qb99q1dRrd86tjx8=;
        b=tJF5o9kSy9dX+0Ka71FPJQPXUA6x4omfeWN01yOWKwkRjhhJjWsTv7mth84qpF9CoQ
         jZK5Llk/5jPv5B2G6++ehy8ucWnKxqvkhxkwb/tYR01vw6G8y0Zeu6qrUrlntCA0V4ue
         6BggjwzjnFik5C6qnqVRTN7BPYSuNYsYLoN3X3KgrNry5mfjORGR8P7U7qynxTsfwg0N
         XLMiOc3LYdZkhEV/aAi5aCWFirinI6qnOLCJuGPfbivD2qzUX5REW0go9sAY7gRTrqmD
         qPs0Ql7ZzklOcITQ2TDYL+D2gvGb3QrxRdQoTr+w7xbqEhXlpk+hyKVqcGJ7I1b8bfOa
         x9mw==
X-Forwarded-Encrypted: i=1; AJvYcCX2lcx5zB2BV41QKjdPcgb/rIeKg/Khjk6OxqhZ1oRCrZAc1ot8ALd1t1q/U7oJL/ooTubhRAgONw2SBdzcPaYcZwBHgumpYy4WJA==
X-Gm-Message-State: AOJu0YyBc4qqPZsDK2DSws9IRqcijH0IiiJl45b61Pj8cT+nxmSgIjJY
	71187hhX4H4yBurbWRv5foZ1Hhy7d4B9plHGC6EoNDBYt3LYw/TDuSTw6BsAjBSnx3gfikXn+/x
	PoKWux5fQu13jCAXkNUTxkr8S89unDftP
X-Google-Smtp-Source: AGHT+IEvdvuyosNcpBXx9zppRboT+MKUSGQaqbV8+wpPoKmCN4XTewZONmDddNN+SntENlt3/VUWqa9Nc00YNUd3ed8=
X-Received: by 2002:a05:6871:80c7:b0:22a:4c05:2efd with SMTP id
 sm7-20020a05687180c700b0022a4c052efdmr2030139oab.10.1713416985026; Wed, 17
 Apr 2024 22:09:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOLMD=xWnfEVEobNnE+ipMwi=x7wNA7ZfQo1+9CH8UyUVAffQA@mail.gmail.com>
 <Zheim/iQP31H1pMh@yilunxu-OptiPlex-7050>
In-Reply-To: <Zheim/iQP31H1pMh@yilunxu-OptiPlex-7050>
From: David Gideon <gideonda32@gmail.com>
Date: Thu, 18 Apr 2024 15:00:27 +1000
Message-ID: <CAOLMD=wxmkRti3ny3kDz=hzZfSZeZn2_mdXhqGGPFO+7vPDEsw@mail.gmail.com>
Subject: Re: info->header_size always 0, breaks fpga-zynq.c driver
To: yilun.xu@linux.intel.com, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Yilun,

It looks like I'm using a mainline 6.1.55 kernel, but with Xilinx
patches over it.

One of those Xilinx kernel patches introduces loading firmware images
via the sysfs, and one of those functions calls
fpga_mgr_firmware_load() directly,
without first setting info->header_size (as fpga_mgr_load does).

I guess I'll shoot a message to the Xilinx guys.

Thanks!
-DG

On Thu, Apr 11, 2024 at 6:48=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.com>=
 wrote:
>
> On Thu, Apr 11, 2024 at 02:16:24PM +1000, David Gideon wrote:
> > Hi Everyone,
> >
> > Our Xilinx FPGA driver (zynq-fpga.c) is no longer compatible with
> > fpga-mgr.c and barfs with:
> >
> >       "Invalid bitstream, could not find a sync word. Bitstream must
> > be a byte swapped .bin file"
> >
> > It seems to come from here (inside fpga_mgr_write_init_buf()):
> >       size_t header_size =3D info->header_size;
> >
> > It uses header_size to decide whether or not to call
> > fpga_mgr_write_init() with a NULL buffer and a 0 size, or use a real
> > buffer and real size, like this:
> >
> >     if (header_size > count)
> >         ret =3D -EINVAL;
> >     else if (!header_size)
> >         ret =3D fpga_mgr_write_init(mgr, info, NULL, 0);
> >     else
> >         ret =3D fpga_mgr_write_init(mgr, info, buf, count);
> >
> > The trouble is, that if I follow my code path, info->header_size isn't
> > set by anyone.  So it's **ALWAYS** zero.  But the value **should** be
>
> From your link below, I see info->header_size is set here:
>
> @@ -404,6 +571,8 @@ static int fpga_mgr_firmware_load(struct fpga_manager=
 *mgr,
>   */
>  int fpga_mgr_load(struct fpga_manager *mgr, struct fpga_image_info *info=
)
>  {
> +       info->header_size =3D mgr->mops->initial_header_size;
> +
>         if (info->sgt)
>                 return fpga_mgr_buf_load_sg(mgr, info, info->sgt);
>
> Thanks,
> Yilun
>
> > 128:
> >
> >     static const struct fpga_manager_ops zynq_fpga_ops =3D {
> >          .initial_header_size =3D 128,
> >         ...
> >     };
> >
> > The issue seems to have been introduced as part of commit 3cc624beba
> > which I have linked to here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/drivers/fpga/fpga-mgr.c?id=3D3cc624beba6310a8a534fb00841f22445a200d54
> >
> >
> > What I find really interesting is that the original mailing list patch
> > submission didn't have this bug, and would have worked for us:
> >
> >     + if (info->header_size)
> >         + header_size =3D info->header_size;
> >     + else
> >         + header_size =3D mgr->mops->initial_header_size;
> >
> > Could this be a viable way to ensure that the FPGA manager driver is
> > compatible with the zynq-fpga.c driver again?
> >
> >
> > - DG
> >

