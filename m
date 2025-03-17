Return-Path: <linux-fpga+bounces-1120-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E1EA6592C
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 17:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AE78867B9
	for <lists+linux-fpga@lfdr.de>; Mon, 17 Mar 2025 16:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7FA21A38E3;
	Mon, 17 Mar 2025 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIp/fOc2"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F7B1598F4;
	Mon, 17 Mar 2025 16:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742230028; cv=none; b=EQrk1ZOYybW2SOBSMW244fTTxLBcFOyS+QNfvCKclg3V0WboC4fL2SYw1w3ttoxPjl4xeMwBDMZvX69ZzbmmQUIavGBT7xAjUOMLy4SLhgQrW5+CsShlhPuYMScTPp234LdD4aleVDNS/bimakQTKxvmvLjrtOdd/s3RF1fwgOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742230028; c=relaxed/simple;
	bh=J9MYRq0WSIpjJanPWTYYQQLbbK9VS3BGLDpohw/VGZE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r5PHXmJCdlEGs1OoaLGG3xAWhh7cs7rtr5GVzXuCtD9a3uc3cGXRE21YCrNNx3P2t2cDgGPcf5gUqAoCa6u0SleCmEZU7iVmy9DGtLJZbn5Yp1IaNdwqAU9EFhZ+PSt1PTF8HhMpkXjkVA4bQ+tWrzj2IOka4v6DSAjxSzmPTek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIp/fOc2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390e3b3d3f4so2784404f8f.2;
        Mon, 17 Mar 2025 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742230025; x=1742834825; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uAyBxKzTxvJRC5/WGGhhGtnTs5BTKzKF6XvR/H/spN8=;
        b=KIp/fOc2IhUcV73THkXfY+REb3AlzarjBb6S2UVfAEgBHODiWAxkpOH6X41fP+CiRP
         xoVhc3hgQJPXhlfm18AkC5MRT4GHMAZDgRNpnZx4QGAEOdoC5H8XDSlPxtQw1i6Rv39g
         O5zh3IXlSVOgLR/QaS37Bq8xgevJyM7jkzsFpyKmVDtCCQGuq93ymwQMOvUH83wJQPGV
         eTn1X8T8KlhthFq94VXXSZpz1P6KmO9yHdbJ/k/Flt1d7FblO7154TY8aQoiSnceTo/0
         181sEMrZaDxqwwtvXUhv/mPh1AwX4Gx4dDh1tbXsCHE+jqK5r0yuBASY+/Ed404FB1rR
         C5qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742230025; x=1742834825;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAyBxKzTxvJRC5/WGGhhGtnTs5BTKzKF6XvR/H/spN8=;
        b=NIjws4xkpI0wK3r6uucqcDCyuMIjfBt+wQUk94fhQWrU2qWhuPuW7YSqgDFMohlHYO
         rsQhKgm1cMI5Eu4ydMG/wGd50L2WkbuEUZMwt3dcgLn/1M+6wsJpgnQJLU6rn+xepJBh
         w0VblPilX3sFZAnU3gMrWJae5UcwbcFPoruMMg/4UEZPNdliOMoMKvO9N1ai+Ut/HaV9
         24Q1955r8zQ7/br4PAXR9ymDPUOSooJIYa+0QYDC8yvcU4cqvoMVVwhaP18Qlf58namr
         Z3pXpNEW9CswH/JODgrHI4KoUuEz4JKYglmQYKv7JGPNCovERKpiJFlPzU3ONVMqknF/
         wWIA==
X-Forwarded-Encrypted: i=1; AJvYcCUZvUS4S3v5XF0ayJtJLkRy7MS/y2hjRM9ZHwHFFIE8tVXiRJULDzTHbVs7H3nz2+G6NcaWy3bu2Wtf@vger.kernel.org
X-Gm-Message-State: AOJu0YytNWxGnBFA45UBMCZpuPmrsmrQresmiv/YzSrJQCv7WloRSqtB
	Mhpn1yyZvJZmW6bIhIWE8VpyDZxRqttRwFT2Vc2EGgQZaT6XrtYErHQdmmvKHqPh+Q==
X-Gm-Gg: ASbGnct9bOCbHuIc7PGP1SK54JnJp2yE2ry0hRDlJqmeX8LadTZgu4TfZqYlgDb/LUF
	+WSha5U+hVD6t2eG0/0HyBhDPkuyCH44+BoESyAmISJKRktMxgrqVNyYXYLImvu4EF5zp8yISgv
	nF4DBT8RWmqoTTzILOAy0qDq9N2FVL7ZyB33j4R4mvXwHyiIr75QefU8oDAGcCyRL29P7B/3CQJ
	Orte8IOIC74H7YlLy7+gGszhb3Mef/0DtQBIvqGe2WoByl5Q4CStkXgz+q710wFtU0PimVitx2x
	UZHIf5enYoXiyUsK125QV2ttyAATFFu3YMTDHlT9viP4K+f0wy6f+cjuFL0oGMqOOPMr17U/bkO
	DanQwh53aLef8fn4yPKvRLBECGXQ=
X-Google-Smtp-Source: AGHT+IG9YBsksBRMimxUXllxOj4pW95lHtJ5m4l0SffJMko1iYGRDEII9ew95NTswdejpnWrn0Nv6A==
X-Received: by 2002:a05:6000:2a8:b0:391:10c5:d1c6 with SMTP id ffacd0b85a97d-3996b43e7ffmr458905f8f.2.1742230025480;
        Mon, 17 Mar 2025 09:47:05 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6e4esm15342361f8f.29.2025.03.17.09.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 09:47:05 -0700 (PDT)
Message-ID: <7011e3f92e812c6b35ef71c3e314faabdc7d6793.camel@gmail.com>
Subject: Re: [PATCH v2 6/6] clk: clk-axi-clkgen: fix coding style issues
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>, Nuno =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, Stephen Boyd	
 <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Moritz
 Fischer	 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun
 <yilun.xu@intel.com>,  Tom Rix <trix@redhat.com>
Date: Mon, 17 Mar 2025 16:47:11 +0000
In-Reply-To: <402a575c-5bfc-4dac-bac6-d7f4e7ee5462@stanley.mountain>
References: <20250313-dev-axi-clkgen-limits-v2-0-173ae2ad6311@analog.com>
	 <20250313-dev-axi-clkgen-limits-v2-6-173ae2ad6311@analog.com>
	 <402a575c-5bfc-4dac-bac6-d7f4e7ee5462@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-03-17 at 08:26 +0300, Dan Carpenter wrote:
> On Thu, Mar 13, 2025 at 03:14:48PM +0000, Nuno S=C3=A1 wrote:
> > @@ -224,8 +226,8 @@ static void axi_clkgen_calc_clk_params(unsigned int
> > divider,
> > =C2=A0
> > =C2=A0		if (params->edge =3D=3D 0 || frac_divider =3D=3D 1)
> > =C2=A0			params->low--;
> > -		if (((params->edge =3D=3D 0) ^ (frac_divider =3D=3D 1)) ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^
>=20
> > -			(divider =3D=3D 2 && frac_divider =3D=3D 1))
> > +		if ((params->edge =3D=3D 0 ^ frac_divider =3D=3D 1) ||
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^
> This works, but the code was a lot easier to read with parentheses.
>=20
>=20

Yes, I'll do it in v3. Just waiting a few more days for additional comments=
.

- Nuno S=C3=A1


