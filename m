Return-Path: <linux-fpga+bounces-1438-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1EC4938C
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Nov 2025 21:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133933AEFDB
	for <lists+linux-fpga@lfdr.de>; Mon, 10 Nov 2025 20:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E69E2EC0B0;
	Mon, 10 Nov 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKZqXayJ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C6828000B
	for <linux-fpga@vger.kernel.org>; Mon, 10 Nov 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806264; cv=none; b=uNQvpGlouJ4yUgMwWZqKBj3kGhHeT63kZ7YncvNHqfranE+NSHTl7Orjzhk0HQO4td7qG3W1yu0pVk8E24siYpk04RwAVkATtE30kRt0C5Pcsik2tMa+DXGgMmvc3u8xVoc0K2zlRiDBokSywo6LvPXqW8AhoL6F2ujw/NduJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806264; c=relaxed/simple;
	bh=MM9+8E+GZgDraH0Himq5JuKGwG+RbTe11fXxGHrRfl8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3OlQMnn8cVP8sgfGEhMn8ZRHnIvWALxKmvHuY8oK5aPB5zQhViU8HqQup8OL9Sv0dlXvFsWeLPvT+Mw9lAiMwyNb5XC/j0RH5r0qwffgOvPAzJ/NiD9YYNPwd8vjKE9eg8T/9lEAtj9o6rwhQXi46oglCy+OxILNWkYJymdmws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKZqXayJ; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-63e393c4a8aso2647676d50.2
        for <linux-fpga@vger.kernel.org>; Mon, 10 Nov 2025 12:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762806261; x=1763411061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YLJvRTwWAHeioYw48ioM3TOlUOIaEqWMfhP+92vigo=;
        b=BKZqXayJQxw5qpzNXIy+aZGTL6zKgeX4gcxy2A+DpRII4HudSosKJEO244QuWkBZ4R
         JIic7K+6sl8lGH+nton8FjN5MSUJZXyklUqtTx1J/DdmVjd1ayl+HRCEfwYEsvvwPc6t
         Dw8/MSY3mSqLEERt+nwaEPNSq4x/dBQZ52z/SlBzbHpZQtt4j+ZCtXdPFbNZXzs6fIaj
         TF30QtPV2BLDGQQzDfPnpVW8KmufSXttinS96ECjx97sy6Z/GoRxe+V2tWgrgzI38O73
         ONSasiv9JQaBcdD1FGvFuGZpMBdlRUjn8kz2gmMXu8wDOthxkt4pIbKYqaZIdJXsEj9v
         yt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762806261; x=1763411061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3YLJvRTwWAHeioYw48ioM3TOlUOIaEqWMfhP+92vigo=;
        b=bvq+PRN8rhxa7AsI60PTfSb1CbLHDMf/dfuuGEJKsjfUXr0ReHgXmF8esDPB1TzLYH
         ekma4rF9dwNLpn5cPVcMiYf/Lm7oKwyu3C66rfpvv6Aikd0gWGy3N4mOAYe1CxdkLt5y
         ObkaNYQub0WIJmIcwUf0bilHxktP0ae35FhhCEAwh6MuNRS+CvbRMISVWhGAyBVabXwM
         BiRnSL8E1hwh9qCvqqbJm3DVw7UdCF3Afm8GRuJVDRA1B7eUXFjV4ZMyPj8scC4JFH6T
         u2InGw0qgQtP+J7LDyG0qy2uuTqlSLEMQFx3H0rZAbhrIb/zl7dGmA3qEJZCupnNbvIg
         hvdw==
X-Gm-Message-State: AOJu0YxhifYwAlRwchAVJrysBwIVXlkZWDcLAAq9EQfIJreJKWE9Pqry
	80ywmnsnMx4rcnoIU38p9MOC9aKptlbqFmsjgEbRv884CkT2cIXJ7bbbH2KqLDI6pPYNx+C4PJk
	Ot62RK7oPzvhon/F7ZNqWAgakDNmFODw=
X-Gm-Gg: ASbGnctRiRPp2BTAl9kfVy2gVOe6OGoN1ij3XBKY6EDcxHHIyD+3wWDpRWR4zso4g9w
	SHoxIsnLLM0HdO+T+n1npQkq1vec1DS5B6B/eyv6sezqivKcFxUtagTKSh4wVvRQviIzkVNPs7E
	RJbd5/R+BdZcFuw/PL7SVx1tQbaQ8/+bWXZDVDCz/l4DNrnZH3GG0L4l0i2mtJ0rrWdFDs75iKR
	kzfte5RBG98HK7m/hGh3MiQ0cgUXDFdRDjdWqkVMHMQaBslgf+RbQQW99KPkJmtOmtmk9vEZBDz
	Pv1b16AF
X-Google-Smtp-Source: AGHT+IH1mIDulGVb7q7tn5z5ztHbSvLB3cHEN5rgeiioPy3PtF0rCncjMwbJ6yUVoHomSJF2gUM87uyh+BkEJDcXbuE=
X-Received: by 2002:a05:690e:2557:b0:63f:b4db:91e9 with SMTP id
 956f58d0204a3-640d45b7279mr6137231d50.49.1762806261436; Mon, 10 Nov 2025
 12:24:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106185938.6419-1-rosenp@gmail.com> <20251106185938.6419-3-rosenp@gmail.com>
 <aQ2csK4TtTOFmyLj@yilunxu-OptiPlex-7050> <CAKxU2N8QHoQxb0ddUtMTtK6psL4gPPGSTwTf5X=7py22GXxkrw@mail.gmail.com>
 <aQ7As9KVG+5Dn5FB@yilunxu-OptiPlex-7050>
In-Reply-To: <aQ7As9KVG+5Dn5FB@yilunxu-OptiPlex-7050>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 10 Nov 2025 12:24:08 -0800
X-Gm-Features: AWmQ_blHnwZ4jZXTsCH8nSi2m1cRiASy-p1toImjcRejScKOeL7cr9yZYRwJRcY
Message-ID: <CAKxU2N_ssbQyGAHuRma8UqxesoGrVsTrPNY=hjfCZXKx__vj=A@mail.gmail.com>
Subject: Re: [PATCH 2/2] fpga: stratix10-soc: add COMPILE_TEST support
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, 
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 8:16=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.com> =
wrote:
>
> On Fri, Nov 07, 2025 at 11:28:03AM -0800, Rosen Penev wrote:
> > On Thu, Nov 6, 2025 at 11:30=E2=80=AFPM Xu Yilun <yilun.xu@linux.intel.=
com> wrote:
> > >
> > > On Thu, Nov 06, 2025 at 10:59:38AM -0800, Rosen Penev wrote:
> > > > Allow the buildbots to find compilation issues.
> > > >
> > > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > > > ---
> > > >  drivers/fpga/Kconfig | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > > index 311313f3b282..f2e2776acdd5 100644
> > > > --- a/drivers/fpga/Kconfig
> > > > +++ b/drivers/fpga/Kconfig
> > > > @@ -60,7 +60,7 @@ config FPGA_MGR_ZYNQ_FPGA
> > > >
> > > >  config FPGA_MGR_STRATIX10_SOC
> > > >       tristate "Intel Stratix10 SoC FPGA Manager"
> > > > -     depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
> > > > +     depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE) ||=
 COMPILE_TEST
> > >
> > > I don't think it works without INTEL_STRATIX10_SERVICE, maybe:
> > >
> > >         depends on ARCH_INTEL_SOCFPGA || COMPILE_TEST
> > >         depends on INTEL_STRATIX10_SERVICE
> > >
> > > But INTEL_STRATIX10_SERVICE depends on HAVE_ARM_SMCCC, and they all
> > > require arch configurations...
> > Yeah I don't think INTEL_STRATIX10_SERVICE is needed for COMPILE_TEST.
>
> Have you actually passed compilation without INTEL_STRATIX10_SERVICE?
> I can't image how it works without stratix10_svc_xx kAPI definitions.
Based on kernel test bot, It seems INTEL_STRATIX10_SERVICE needs
COMPILE_TEST too.

It also needs fixing. On 32-bit, I get this output:

drivers/firmware/stratix10-rsu.c: In function =E2=80=98rsu_get_spt_callback=
=E2=80=99:
drivers/firmware/stratix10-rsu.c:285:28: error: left shift count >=3D
width of type [-Werror=3Dshift-count-overflow]
  285 |         priv->spt0_address <<=3D 32;
      |                            ^~~
drivers/firmware/stratix10-rsu.c:289:28: error: left shift count >=3D
width of type [-Werror=3Dshift-count-overflow]
  289 |         priv->spt1_address <<=3D 32;
      |                            ^~~
In file included from <command-line>:
drivers/firmware/stratix10-rsu.c: In function =E2=80=98rsu_status_callback=
=E2=80=99:
././include/linux/compiler_types.h:597:45: error: call to
=E2=80=98__compiletime_assert_377=E2=80=99 declared with attribute error: F=
IELD_GET:
type of reg too small for mask
  597 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |                                             ^
././include/linux/compiler_types.h:578:25: note: in definition of
macro =E2=80=98__compiletime_assert=E2=80=99
  578 |                         prefix ## suffix();
         \
      |                         ^~~~~~
././include/linux/compiler_types.h:597:9: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  597 |         _compiletime_assert(condition, msg,
__compiletime_assert_, __COUNTER__)
      |         ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg=
)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/bitfield.h:72:17: note: in expansion of macro =E2=80=98BUIL=
D_BUG_ON_MSG=E2=80=99
   72 |                 BUILD_BUG_ON_MSG(__bf_cast_unsigned(_mask,
_mask) >     \
      |                 ^~~~~~~~~~~~~~~~
./include/linux/bitfield.h:155:17: note: in expansion of macro
=E2=80=98__BF_FIELD_CHECK=E2=80=99
  155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET:
");       \
      |                 ^~~~~~~~~~~~~~~~
drivers/firmware/stratix10-rsu.c:122:40: note: in expansion of macro =E2=80=
=98FIELD_GET=E2=80=99
  122 |                 priv->status.version =3D FIELD_GET(RSU_VERSION_MASK=
,
      |                                        ^~~~~~~~~
>
> > >
> > > >       help
> > > >         FPGA manager driver support for the Intel Stratix10 SoC.
> > > >
> > > > --
> > > > 2.51.2
> > > >
> > > >

