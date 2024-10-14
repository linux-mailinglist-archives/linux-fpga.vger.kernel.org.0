Return-Path: <linux-fpga+bounces-771-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB92C99C2C8
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Oct 2024 10:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 762431F21E9D
	for <lists+linux-fpga@lfdr.de>; Mon, 14 Oct 2024 08:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA34E14D439;
	Mon, 14 Oct 2024 08:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="p0qNWgk7"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8AB14B946
	for <linux-fpga@vger.kernel.org>; Mon, 14 Oct 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728893763; cv=none; b=jqxIfJ+0vl39qtTQPbnwI6sGPb+5DecnFn00ZuEczLXJ/JgweRe7A/Oa7pafmalAzgYQZgC0r7l8xzVXMSqx/VOr3wk79wxfukS8Hk6jfc3Y44ZsXeHv+HSI4dD6McqXrAmwX5sMhJ5mXPpGqmaak2rY+oYNNbUbweNhQKwC3Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728893763; c=relaxed/simple;
	bh=ZgDKMVeLxznmFf5ZCrSGz0IvyrvooVbXTGlKGwkLa+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=id/Wqy/50R8BPRACbkqI0wCSVwa64AlP0hohkdWWqyOVhW+MWhxoXNQgkvTy2H01Do7wMb70yzdqq1gv97HQ1ykjLa3oq72V7QviN3eP03lvW1BtD9tdzEsfivWY5wYx6UOZGlO2lFeWNnU2AW3tmzaAQWZRRi3T9Hl8X92Br24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=p0qNWgk7; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f53973fdso594409e87.1
        for <linux-fpga@vger.kernel.org>; Mon, 14 Oct 2024 01:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728893760; x=1729498560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZgDKMVeLxznmFf5ZCrSGz0IvyrvooVbXTGlKGwkLa+s=;
        b=p0qNWgk7lgNR73CDmbKNCe8carjDxZi5xf7N5xFzH/WMMVlLSUad0tKT9vbRpGgrsk
         fK8g/NCV+Ewiq8Ax+HaeaRtSqErxlSJXzqCDz9i5XSFO3po2Q52HsuKbwjx8sGmTYMt1
         nH1K8Y4OlmzNA9OE7/2r3CFiXSvo9JfE/ThDXDZBw/6GF/+yTJWyN87w85pqTL0A89Mj
         1+fcgL5kStWyCjlHDZOiauonOZ0xlxafbmCsZAvnktDvHAN8kgi4tPwur68F0YWSz+HN
         TWSZq7iKZBsBQFatlhV079Dkw3CH0E+DR3x4Uc8Bm+B7dDKfBDZtFGMurW/rJkvmO9h/
         zaTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728893760; x=1729498560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgDKMVeLxznmFf5ZCrSGz0IvyrvooVbXTGlKGwkLa+s=;
        b=rvkqn7UjvV/fTzF++9nBcs/d/jQVtZ8/mfL3RdAboj7/pmPYrG2qitczmoA7qpUpsW
         gpNwMo08i26LOtPCb1WoKacTmhjKgdgT+CI6Xoo53lT790uJ8DgCHS7iviOoKySoaYYn
         YuuXDyyCwiaW8QdLuWckiBMm80K8AgWumSJrjHRVznkQBaNfEUqoF/+OC11CY/qJYvKb
         6PP1hYuCvglTT+argJ344Ut6pO3N6H27jIrk6E34Z4aZixd9583CBrUTnQuaZZ3QyYgP
         x041DmMHcRPzwhME24GV99LISW1zSgVQ7oXkEBhD6iNMxHMLyFeTNVPQHaF6Hedl/3iq
         3OJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQV2xXYbraRvrKv49gbdtXtcxGyzGF+oLAs3Nh7+9vzvVGKH4HTdNhYkCNIoDiIm75l5OO1AWpk5sL@vger.kernel.org
X-Gm-Message-State: AOJu0YyLpuT/lgquVLq33Xk6402K62bsMd5SgGRUEWeZBT6AO6uEd3dg
	Uzd4B+k5vBzMPOlgO4LdaUyu87IoTeG1Pfi303BE5GaKKnMr1sKZ9WDcKdkHZdeQGkARuPs5UX5
	hoq5TPSzrwxD0dRAI3vLmaI2mvHsfTbKT0utaQA==
X-Google-Smtp-Source: AGHT+IHdDAIjXYd2S69FLZv9SLr0zTg0livk5nl6SwOydMcHkiUKTf2/hmy4fWdIKBPYwmr/c88DMXlSKUPi9UaNRr0=
X-Received: by 2002:a05:6512:3d1e:b0:539:9f5f:efd5 with SMTP id
 2adb3069b0e04-539c98b923dmr4809047e87.26.1728893760273; Mon, 14 Oct 2024
 01:16:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014075329.10400-1-pstanner@redhat.com> <20241014075329.10400-5-pstanner@redhat.com>
 <CAMRc=McAfEPM0b0m6oYUO9_RC=qTd1vsg4wMn1Hb4jYQbx4irA@mail.gmail.com> <dc9d7bd817e5c8bc88b0b8dfffcf83b2676cc225.camel@redhat.com>
In-Reply-To: <dc9d7bd817e5c8bc88b0b8dfffcf83b2676cc225.camel@redhat.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 14 Oct 2024 10:15:49 +0200
Message-ID: <CAMRc=Me8U+7EwNDEh2RJJD8+FTPqO-CbwG_fiDmHLpjxh33o5w@mail.gmail.com>
Subject: Re: [PATCH v7 4/5] gpio: Replace deprecated PCI functions
To: Philipp Stanner <pstanner@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Richard Cochran <richardcochran@gmail.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Al Viro <viro@zeniv.linux.org.uk>, 
	Keith Busch <kbusch@kernel.org>, Li Zetao <lizetao1@huawei.com>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:08=E2=80=AFAM Philipp Stanner <pstanner@redhat.c=
om> wrote:
>
> On Mon, 2024-10-14 at 09:59 +0200, Bartosz Golaszewski wrote:
> > On Mon, Oct 14, 2024 at 9:53=E2=80=AFAM Philipp Stanner <pstanner@redha=
t.com>
> > wrote:
> > >
> > > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > > the
> > > PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> > >
> > > Replace those functions with calls to pcim_iomap_region().
> > >
> > > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> > > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > ---
> >
> > This is part of a larger series so I acked it previously but at
> > second
> > glance it doesn't look like it depends on anything that comes before?
> > Should it have been sent separately to the GPIO tree? Should I pick
> > it
> > up independently?
>
> Thx for the offer, but it depends on pcim_iounmap_region(), which only
> becomes a public symbol through patch No.1 of this series :)
>

Then a hint: to make it more obvious to maintainers, I'd change the
commit title for patch 1 to say explicitly it makes this function
public. In fact: I'd split it and the deprecation into two separate
patches.

Bart

