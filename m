Return-Path: <linux-fpga+bounces-1170-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EF6A96364
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Apr 2025 11:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720F63BDA8F
	for <lists+linux-fpga@lfdr.de>; Tue, 22 Apr 2025 08:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343EB25D91B;
	Tue, 22 Apr 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ciOuYgUs"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62908190472;
	Tue, 22 Apr 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745311994; cv=none; b=D5RiSLJuLD+xiQl5XgOOoEIjQGMmrdOE13cHANHmnOI99+rnaWy68Iwjty2l8rETTrcRetjHsvYEap4Mcfe/iGwTqAETqHJA4ntLWeSQ6KTbqRIdXSvpVgbgsAPeVQoQ+XZ5C2Rlq+8TETWRo7+lY3TyYzq8r9URqy7efDwxAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745311994; c=relaxed/simple;
	bh=MTO6bJT52D5H05b8xEgXzGe9Neulg6gfBNZWu0o1/bk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nj4+hfGQndXS/EtQ3eIM93B6M4jl9EaBckCQsj5PizO1L3EHrzn4WnZ+ZTSNsEuLqz3BmT8MyRAHzT1X1N8D1kzsDkoGSACElENkSokZ6AwU35ku+zKcVikkV02cyJdKLXSzeMWuE2fKnjdC+WjiONkdu708Iv4JhmtgFeIQkf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ciOuYgUs; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so42767885e9.1;
        Tue, 22 Apr 2025 01:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745311991; x=1745916791; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MTO6bJT52D5H05b8xEgXzGe9Neulg6gfBNZWu0o1/bk=;
        b=ciOuYgUsp6zaw4s90UNP74XpKsYwvtQMypMgqcnSQ0PH9FnRR4gnJBAlvaa/ef59cj
         PtlpxUzyg/xU7V2zzhhcw8nxeIzdFggHJthHNr4b0bebx5BsgfS8eYXbNXksLBvUSrwu
         nCPqyhDB2SVzf8xH/uWGXXFXTaQ1qwipDQm35XGJszHCo9HPKVr7xpq6jWvVklJLySKJ
         NAgq5BNqF7qO50dJSfLvMf4KzK9JdaQwI8dm8Rjzdc758l2lCBbDf8ectEXBsOG7Sb63
         5xmur2fHLEQ5k1ML/L8lfaqlf2PIV3vkfCzYFKp3eUQTt79BTpXOippA9Ha+JSQknY6U
         1g8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745311991; x=1745916791;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MTO6bJT52D5H05b8xEgXzGe9Neulg6gfBNZWu0o1/bk=;
        b=vENyEdxwSf9oIyfoydPQSZVabh8HXoYCotr30YVXZY+rw3BQd2A9gCiMxw5qFM+P84
         GTHiSfR0RszsmoiO88E/fKjXb0wFktsTMajcZkexS+QBj3v12cafjP6oO+1ZryZ4ByuA
         CdDZVsCuRTvv25g1N5L0ALJKId96G8Rxlf8MzGI5VJmlpRo3Km82nLeMvgVBRcv46JBI
         hU4TOml4g4+6c+o6n+SOLdtr9AitOOKIeu381gQRK/wmPjXhQQ8AcYL4kRg16a1uvgVt
         85+htD1Iy+/HxBaNoirg697MCZkQr7VIpbnZpjpN+wd0omOXgl64eC/z7vE+6F2PcE8c
         nttQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHWmY0mXSF88d5E7LikWZwK1/FjjDVWnKyy7LBycSZzBoQ0K6PTlBpuXo//llZOtN7F2O8rGa6h7a8Pw==@vger.kernel.org, AJvYcCXhuCgd/EEqE8I/gd31ItrmDIO1RomY2VM6yZUSueDwVIZ5mWzeaWiCDbifOhxh7Ns/lbCDdb3Jsqs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2RDqgRPmq/aRDm6PZHyrg2UDbvERePq8SQUunBXM0jfxGoy5s
	edSGDBbdLsmuS6QC1DmonPwpaw8IybvW5Xm9jaWNRe/okPJRO2LE
X-Gm-Gg: ASbGncuYpoHY/RGvRIdqDRzHKdony1g9MnDhgBnYv8WRyGGlrZH/s0IKSLrap1X8r9U
	jSf6XgxNZ7++tbWjDWV6PBcYChLObWN3qJdfQHq1ASGPLSJWQzCsEl4dxlctgErslrv4BKWTGwj
	BsroLavBVyCFYn+wqFIHOrGWwv86naQv207bOaJ0sHfsOsVWxHUAnEoo5SVouTY1vYPcT2/0/eC
	wEEjcYfmES8MB+EDgIyoPiMq46lzWLGWbdrT7BYPrrwLy2ql/KYFdA4fjw6JCnH3EeGPZ0GJVbO
	aPxsUU1vqgSVUnB3aedHdCOP/jRFKgLJRthPKY9WPDPdYJmG9UoT89IxxCbm435W4AEhuhbtiJY
	9rloCiWK127Ue
X-Google-Smtp-Source: AGHT+IHXl4tbgWU59wOiuDJym9FjdSvPSmEuiXWKdiJLHRiobOsRDv2lQA3FHFEtDilDrBWt35SGHg==
X-Received: by 2002:a05:600c:1549:b0:439:4c1e:d810 with SMTP id 5b1f17b1804b1-4406b235409mr107404495e9.9.1745311990603;
        Tue, 22 Apr 2025 01:53:10 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d563297sm165370915e9.0.2025.04.22.01.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 01:53:09 -0700 (PDT)
Message-ID: <3d329a888567432e73b25f264342a281d60182ee.camel@gmail.com>
Subject: Re: [PATCH RESEND v3 0/6] clk: clk-axi-clkgen: improvements and
 some fixes
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: nuno.sa@analog.com, linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org
Cc: Stephen Boyd <sboyd@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>,  Moritz Fischer	 <mdf@kernel.org>, Wu Hao
 <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,  Tom Rix
 <trix@redhat.com>
Date: Tue, 22 Apr 2025 09:53:13 +0100
In-Reply-To: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
References: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-04-21 at 15:58 +0100, Nuno S=C3=A1 via B4 Relay wrote:
> This series starts with a small fix and then a bunch of small
> improvements. The main change though is to allow detecting of
> struct axi_clkgen_limits during probe().
>=20
> ---
> Changes in v4:
> - EDITME: describe what is new in this series revision.
> - EDITME: use bulletpoints and terse descriptions.
> - Link to v3:
> https://lore.kernel.org/r/20250407-dev-axi-clkgen-limits-v3-0-33c7f27c9d6=
9@analog.com
>=20

Disregard the above please... Messed up with b4

- Nuno S=C3=A1

> Changes in v3:
> - Patch 6:
> =C2=A0=C2=A0=C2=A0 * Revert change and parenthesis back on 'if (((params-=
>edge =3D=3D 0) ^
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (frac_divider =3D=3D 1))'. While checkpatc=
h complains, it's more
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 readable like this and in some configs we =
might even get -Wparentheses.
> - Link to v2:
> https://lore.kernel.org/r/20250313-dev-axi-clkgen-limits-v2-0-173ae2ad631=
1@analog.com
>=20
> Changes in v2:
> - Patch 3
> =C2=A0=C2=A0 * Rename adi_axi_fgpa_technology -> adi_axi_fpga_technology.
>=20
> - Link to v1:
> https://lore.kernel.org/r/20250219-dev-axi-clkgen-limits-v1-0-26f7ef14cd9=
c@analog.com
>=20
> ---
> Nuno S=C3=A1 (6):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk: clk-axi-clkgen: fix fpfd_max frequenc=
y for zynq
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk: clk-axi-clkgen: make sure to include =
mod_devicetable.h
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 include: fpga: adi-axi-common: add new hel=
per macros
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk: clk-axi-clkgen: detect axi_clkgen_lim=
its at runtime
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk: clk-axi-clkgen move to min/max()
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clk: clk-axi-clkgen: fix coding style issu=
es
>=20
> =C2=A0drivers/clk/clk-axi-clkgen.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 147 +++++++++++++++++++++++++----------
> -
> =C2=A0include/linux/fpga/adi-axi-common.h |=C2=A0 35 +++++++++
> =C2=A02 files changed, 140 insertions(+), 42 deletions(-)
> ---
> base-commit: 82f69876ef45ad66c0b114b786c7c6ac0f6a4580
> change-id: 20250218-dev-axi-clkgen-limits-63fb0c5ec38b
> --
>=20
> Thanks!
> - Nuno S=C3=A1
>=20

