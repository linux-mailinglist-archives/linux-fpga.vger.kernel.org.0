Return-Path: <linux-fpga+bounces-818-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910B09AD4BF
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Oct 2024 21:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC14C1C225D4
	for <lists+linux-fpga@lfdr.de>; Wed, 23 Oct 2024 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F661AD3F6;
	Wed, 23 Oct 2024 19:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZebbuBqm"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4881D4177
	for <linux-fpga@vger.kernel.org>; Wed, 23 Oct 2024 19:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711599; cv=none; b=GfkefybwbGtQCVpmLzvKgN2VYowE14X0gSBa8jouoB+orrmrvPDP9W2AQ7UFbQHncwmA0zd8+C7XVn4qU2EqNTrWFRBcpT9DvBHCWEO87cvnxKl7AqwJZcHEX0jjAV+YqtHS2oZ8t45pg+7licu6ZfnmyOugAM4motWqVC4q0fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711599; c=relaxed/simple;
	bh=jVfaEMDiqxEbMojHP9PBFB3cC/z3et13Xb9WEIyCI8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K80rRdff+pBGCvNI6Mj+dUBpENefVBIdl58bpOMiZa6YybGCSV13/wILQtbHyY+cIZP7cSuKkd8LWLel1z4caIcbcCJB4C0/BiE13gmtzUs9Y4pxG2gG/G4eSBKz3Y8wIX6UPmPz3pMnmm6aa1NY1tBB57B2GnUroeuEMWghsfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZebbuBqm; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c984352742so153574a12.1
        for <linux-fpga@vger.kernel.org>; Wed, 23 Oct 2024 12:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729711596; x=1730316396; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=ZebbuBqmQ3Hd1o3Js2kbpWRfLUo4MPr+yeh7K1VMaVhIPfFWfejLIK8swuyA87J2Cr
         kksRazJZND4Z0SHJUCW/DmRNb/f/uJbib06ZqAXMQjp07tpEDZxAxZJdc/GPiheY81PE
         KwUkrA/ajCagDaXUm9DlH4//Xr2vaNCnIJffk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729711596; x=1730316396;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=D+HgSm3E4h3Uck1b6VbJeYF5oLeEwM3mzX73DhAZk7tKC4uOPoXFBVT03yjpAxOTnR
         oZzVakZlf4IRlxR8vjp5aAJUU1NjJ2qzc6wPNOKjb1srumInPKOkon+EusId9OkfpSwa
         oCsREzi5RF+iesk2todi8mqZqPGuXmU8eK+XwRr4fEos8ev+91z5iwNa3KxK8CqmBIle
         eHjrBrVMt2GZLA2PqGZZqcf/BrP6QYLNxWmOQ4CJdrSVlErg8PkGQztENLfH9byVew+d
         hlXuRhZrxUHAiJgiBEOuDNapcD/s9ilDALFCmk+YkRZiiq3jD04oKZ6HtBcFyhaWrnd7
         YKcA==
X-Forwarded-Encrypted: i=1; AJvYcCWB+59Y93WGuxoiFLHngWWjZ6BOZJxr3nN05XOJWCwCctTfwIh+aDhXIeRW9NYwq6BXmD753YaWr3qg@vger.kernel.org
X-Gm-Message-State: AOJu0YzRuepDgB3QU8ELaVnnhXjMoCupXV1x8O9Op4YdpzX/r8/a03i6
	kQmUPvO19/0I251/18ImxnVJ1gKbUTanvvtaVzR1IXjWBGaFTzYGCx5NMxSC/e3Fm4MyN+6V3SK
	Qn/BBiQ==
X-Google-Smtp-Source: AGHT+IGq/BX8QW+GjAePIkPe3TEg/QWXzsc5u+KfW0mqDFslHnFk5g48Drtn8s3ZAe9jG3Zvvd2XpA==
X-Received: by 2002:a05:6402:51c8:b0:5cb:69a2:7ad0 with SMTP id 4fb4d7f45d1cf-5cb8b1ad3acmr2626350a12.32.1729711595869;
        Wed, 23 Oct 2024 12:26:35 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c6b1adsm4770429a12.69.2024.10.23.12.26.35
        for <linux-fpga@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 12:26:35 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so12604566b.0
        for <linux-fpga@vger.kernel.org>; Wed, 23 Oct 2024 12:26:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/Roi+Y4eNOTOSdzf9t4xdCPRikVKr66pvp5wUP48ChmO/pise6pmf94PnoqZl+Oash1xVR+vGc+BB@vger.kernel.org
X-Received: by 2002:a17:907:72d5:b0:a99:f4be:7a6a with SMTP id
 a640c23a62f3a-a9abf91ed4fmr407338266b.47.1729711194415; Wed, 23 Oct 2024
 12:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org> <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
In-Reply-To: <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 12:19:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Peter Cai <peter@typeblog.net>
Cc: Tor Vic <torvic9@mailbox.org>, Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, 
	gregkh@linuxfoundation.org, wangyuli@uniontech.com, aospan@netup.ru, 
	conor.dooley@microchip.com, ddrokosov@sberdevices.ru, 
	dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com, 
	geert@linux-m68k.org, hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org, 
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru, 
	ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org, 
	s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru, 
	tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 12:15, Peter Cai <peter@typeblog.net> wrote:
>
> Again -- are you under any sort of NDA not to even refer to a list of
> these countries?

No, but I'm not a lawyer, so I'm not going to go into the details that
I - and other maintainers - were told by lawyers.

I'm also not going to start discussing legal issues with random
internet people who I seriously suspect are paid actors and/or have
been riled up by them.

              Linus

