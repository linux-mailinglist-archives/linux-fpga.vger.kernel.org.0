Return-Path: <linux-fpga+bounces-1177-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E985EA9EB5F
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Apr 2025 11:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB2D3A5129
	for <lists+linux-fpga@lfdr.de>; Mon, 28 Apr 2025 09:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E6B25D53E;
	Mon, 28 Apr 2025 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjLEe4FZ"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB4F17BA6;
	Mon, 28 Apr 2025 09:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830949; cv=none; b=p9N9+ZPGNHvZ5sjeEQGTCVJbO1tDrc0jcMBrY2BdRLfM47/Yc5HEuMBT5uigh4R4qYOBGdvCllp9YuxQTCrpSkIRVetWSc3AV+AVGd9N9KVABm+dMwya5dP/a+pGeOupiCPZLB+e1zwXq/fxLLsJovtYn/920oB0k9MNuKCzbhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830949; c=relaxed/simple;
	bh=pT3WDzu78kO/va+SQ0+NZHFS9bs7FfRts9JiVPsCcYA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YjhSl9u/nTpkWbmRkZUsunR2FxTsKGyyVzqxIEf5cYIuKhdH+PnbrVVutU8w9U6Eb2W8KjAW7xP/VHs8I6gyU6e1O+DHfENB2aqlfqGt462PjjPciMTESNmwwori2W6sGp+LyA8cMHZR1oYfNZctFBGY3cFy2MWGDBvrLEadjsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjLEe4FZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3913d129c1aso2942496f8f.0;
        Mon, 28 Apr 2025 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745830945; x=1746435745; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1i8aCXxUVK2DhAP1mfTWOQhU4rxphPR3JI63bKHZ020=;
        b=OjLEe4FZRXv1eng2JgIEm7USL8B44ALBd+yEI87P31C1N6LKIMz7Rijk7kJFjLFGk6
         EOil6joMQ7ApnYkJdPau1b47abQamQ4GuX5OumG3Hl9lK1QkAczv0xi9YO+ltAwe8Bgy
         +9S3m7RvxlUD153d19NAgXTHqiWzpHFAYHCySz8ZWoRjKpTtrhK55H5ZEoRkCYJAm+Lp
         pZ/wcWT833PZjscAShBLl/YsLWCQia7R77JDwytMnZYiK7A4I+/cYPNu5pBLyE/+24ic
         tzjNIdOT04Yof6WSEffkD7KibCyBSaX+z3Hn7l6fX/vOwtSw6dETXHkJ1QEMeeIydh2D
         vOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745830945; x=1746435745;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1i8aCXxUVK2DhAP1mfTWOQhU4rxphPR3JI63bKHZ020=;
        b=ILY4fzW+TfuDlIPGNWUvFn6McKk/pRpcIjASogufEv6xR2FM3ioeOpScN+WXmdef3Z
         ymvVB9xAz7pV2PlUuxKUeHnJsv1nQtu+dvYZH4cxYCYBJoyoD8r+ZBHeFpCJunn/Te4d
         3ygU1VEfyO7atHmq/9ybVsIAmdlN+eeRD1AeYSg7+gGbIWPqP2hrB7/oSZzL1T+/udG8
         byPqle0vBKoFQjRkTsG2bUEsHAEtWaobelTZvMupiMTCbUfaiVQXoCEhbkojxkAvIzNw
         iu/ctEwTSBcBo2yip6ejISNn6s8hcJjBucKcdDXR0FGdV8D+M1aTM9tsK6RTE9aBQvjn
         8XSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtBzqv+q2eTQfFMT6pTRh5OOifwWKSjVigmzcM+pDnPN3wcE7lZ1WsAtw193+0YwNZ10kAbGJRVYps@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ6o1H+ehLxRDQQOXPip/7J1tAZC5jOSWhLOxRS3AMWjUSSJsG
	92Du9GPfQhfke4481jof3NyOAcLjlPibzeDNgo/QrPnmisb5H0I3
X-Gm-Gg: ASbGnctQp7X5XkJ3f3+k0TFtN7eDsB+jV+wMnuLwktHq860P7Q4E9+xr89I6H4x8M9G
	GzCcB++IiNKCZye5tGRYao4hppY4bgN7VI4ZtM6Dvxy6A2UT/05wITxmu6Yq0VCP58tfJfkLWOD
	wki7tdDVLfVtyQEUM1SsSEKDuVvu9bQh8p04vuzzKlPDsYNfkkGOWYPawDdrSSvargSSE3dJHjf
	78q5Ru6YkKLuWHK0IGSgjpfcorpqQwPp1hi18OSCXBGRkWW5sLTgD+sA2CID/SI1/2VGPqV7SZa
	busV9fM0NPjYQg12TxwhvpAGbELJHoy72Xg75LEZK1T1GVYd80Fdg22lQR3GRyepKPvmMo2OPRX
	VkiH27McU01QG
X-Google-Smtp-Source: AGHT+IEc7ek5RrreSChhQRkzG9P4f7KbWmnhJuiHSgS+idRdwAlTAm9F6+ZYYeMxAM77RmhbFcm5zQ==
X-Received: by 2002:a05:6000:2507:b0:39e:cbca:74cf with SMTP id ffacd0b85a97d-3a074cdb95emr8931367f8f.6.1745830945358;
        Mon, 28 Apr 2025 02:02:25 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8cc74sm10684829f8f.11.2025.04.28.02.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 02:02:24 -0700 (PDT)
Message-ID: <85b09bd3217ed573438bde3f0f37424c9b582bd0.camel@gmail.com>
Subject: Re: [PATCH RESEND v3 3/6] include: fpga: adi-axi-common: add new
 helper macros
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, nuno.sa@analog.com
Cc: linux-clk@vger.kernel.org, linux-fpga@vger.kernel.org, Stephen Boyd	
 <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Moritz
 Fischer	 <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun
 <yilun.xu@intel.com>,  Tom Rix <trix@redhat.com>
Date: Mon, 28 Apr 2025 10:02:29 +0100
In-Reply-To: <aAoPfoL8ZDBK7hf6@yilunxu-OptiPlex-7050>
References: <20250421-dev-axi-clkgen-limits-v3-0-4203b4fed2c9@analog.com>
	 <20250421-dev-axi-clkgen-limits-v3-3-4203b4fed2c9@analog.com>
	 <aAoPfoL8ZDBK7hf6@yilunxu-OptiPlex-7050>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-04-24 at 18:16 +0800, Xu Yilun wrote:
> On Mon, Apr 21, 2025 at 03:58:04PM +0100, Nuno S=C3=A1 via B4 Relay wrote=
:
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> >=20
> > Add new helper macros and enums to help identifying the platform and so=
me
> > characteristics of it at runtime.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> > =C2=A0include/linux/fpga/adi-axi-common.h | 35
> > +++++++++++++++++++++++++++++++++++
>=20
> I'm wondering why these definitions (including existing ones) are in
> fpga directory. They are not specific for any fpga_manager driver. I
> suggest move the whole file out of fpga/
>=20

Just placed them in here because the header already existed in here... If
acceptable, I have not problems in moving this file to include/linux.

- Nuno S=C3=A1

> Thanks,
> Yilun
>=20
> > =C2=A01 file changed, 35 insertions(+)
> >=20
> > diff --git a/include/linux/fpga/adi-axi-common.h b/include/linux/fpga/a=
di-
> > axi-common.h
> > index
> > 141ac3f251e6f256526812b9d55cd440a2a46e76..a832ef9b37473ca339a2a2ff8a4a5=
716d4
> > 28fd29 100644
> > --- a/include/linux/fpga/adi-axi-common.h
> > +++ b/include/linux/fpga/adi-axi-common.h
> > @@ -12,6 +12,8 @@
> > =C2=A0#define ADI_AXI_COMMON_H_
> > =C2=A0
> > =C2=A0#define ADI_AXI_REG_VERSION			0x0000
> > +#define ADI_AXI_REG_FPGA_INFO			0x001C
> > +#define ADI_AXI_REG_FPGA_VOLTAGE		0x0140
> > =C2=A0
> > =C2=A0#define ADI_AXI_PCORE_VER(major, minor, patch)	\
> > =C2=A0	(((major) << 16) | ((minor) << 8) | (patch))
> > @@ -20,4 +22,37 @@
> > =C2=A0#define ADI_AXI_PCORE_VER_MINOR(version)	(((version) >> 8) & 0xff=
)
> > =C2=A0#define ADI_AXI_PCORE_VER_PATCH(version)	((version) & 0xff)
> > =C2=A0
> > +#define ADI_AXI_INFO_FPGA_TECH(info)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (((info) >> 24) & 0xff)
> > +#define ADI_AXI_INFO_FPGA_FAMILY(info)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 (((info) >> 16) & 0xff)
> > +#define ADI_AXI_INFO_FPGA_SPEED_GRADE(info)=C2=A0=C2=A0=C2=A0=C2=A0 ((=
(info) >> 8) & 0xff)
> > +#define ADI_AXI_INFO_FPGA_VOLTAGE(val)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ((val) & 0xffff)
> > +
> > +enum adi_axi_fpga_technology {
> > +	ADI_AXI_FPGA_TECH_UNKNOWN =3D 0,
> > +	ADI_AXI_FPGA_TECH_SERIES7,
> > +	ADI_AXI_FPGA_TECH_ULTRASCALE,
> > +	ADI_AXI_FPGA_TECH_ULTRASCALE_PLUS,
> > +};
> > +
> > +enum adi_axi_fpga_family {
> > +	ADI_AXI_FPGA_FAMILY_UNKNOWN =3D 0,
> > +	ADI_AXI_FPGA_FAMILY_ARTIX,
> > +	ADI_AXI_FPGA_FAMILY_KINTEX,
> > +	ADI_AXI_FPGA_FAMILY_VIRTEX,
> > +	ADI_AXI_FPGA_FAMILY_ZYNQ,
> > +};
> > +
> > +enum adi_axi_fpga_speed_grade {
> > +	ADI_AXI_FPGA_SPEED_UNKNOWN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D 0,
> > +	ADI_AXI_FPGA_SPEED_1=C2=A0=C2=A0=C2=A0 =3D 10,
> > +	ADI_AXI_FPGA_SPEED_1L=C2=A0=C2=A0 =3D 11,
> > +	ADI_AXI_FPGA_SPEED_1H=C2=A0=C2=A0 =3D 12,
> > +	ADI_AXI_FPGA_SPEED_1HV=C2=A0 =3D 13,
> > +	ADI_AXI_FPGA_SPEED_1LV=C2=A0 =3D 14,
> > +	ADI_AXI_FPGA_SPEED_2=C2=A0=C2=A0=C2=A0 =3D 20,
> > +	ADI_AXI_FPGA_SPEED_2L=C2=A0=C2=A0 =3D 21,
> > +	ADI_AXI_FPGA_SPEED_2LV=C2=A0 =3D 22,
> > +	ADI_AXI_FPGA_SPEED_3=C2=A0=C2=A0=C2=A0 =3D 30,
> > +};
> > +
> > =C2=A0#endif /* ADI_AXI_COMMON_H_ */
> >=20
> > --=20
> > 2.49.0
> >=20
> >=20
> >=20

