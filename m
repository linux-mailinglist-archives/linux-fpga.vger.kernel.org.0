Return-Path: <linux-fpga+bounces-1084-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4912A4BBBB
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 11:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99B618930B3
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 10:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3EF1F0E44;
	Mon,  3 Mar 2025 10:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZF1a3DOE"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E23E1E570E;
	Mon,  3 Mar 2025 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740996668; cv=none; b=jq3RcX898x++ut9DDSXib0YHQ8wz4Lj3ZeFhnPCyY2jsRA2Uw+J6QW3KseVqJN+bSQr4GlY3q2HfXr0w1/6KH2zWuZlZDLjdcVywP7FpTV4+QXRrPx9dFccOQ7Vo/P9cCvqZAriJgF+1alwA8//5iJ5gP3zm4RIm94Ogyiz9/2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740996668; c=relaxed/simple;
	bh=lVMnGNEs8TxFgSwIF8htWId8nMt8AO8mYJwWWyOMP6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qObgyxTtvTto08zYiCTB836fSqwrkCQiMeQyUDLbz1y0MvTNgLtvo0pp25+Wa9bo/v/WDG13dJRPNLRYs+/JX0FV6+LDN2MixlxSnGM9vKx8swDNEJmWB/hE32IfbCpcTu/e+WRJLwlaGaPprUG8EzY6lJC6pPpp5ONpN3o9DAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZF1a3DOE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso757632366b.3;
        Mon, 03 Mar 2025 02:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740996665; x=1741601465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmOq6R2kE92BmomVujWVrqVquXQ8oB+8Z2iecBtYk70=;
        b=ZF1a3DOE4iRlU6roxZYi7f/tjKWwVKudl1p6xYqnJx4IZOT+Pbx3L7XCRDtse9fIf+
         x4bsUmjVPA+sDCFx65bwJ7m9xT/tWnIaAsKr71ht227y0X1/DMIVposVJwY8jeuHxFKl
         8sdrkmIvV8uhG6QzdlJIB1FKwf9deU2TdZLZCaCVcLRIHIgpE6s7MKsSxQVZekVCPxxL
         WiJDuYbYF+otqxt9gTRBr5/QywOF6W9P1AXKEynWcGzgpFPka6MmE2LNR33vgdKqtcJ9
         KUD70r9L1wW5EUvzSEchvNhZjuTzpzQSere4tmrHdAONhb2/3Oq6SyfIhZxl+hY0/SJ1
         yU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740996665; x=1741601465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KmOq6R2kE92BmomVujWVrqVquXQ8oB+8Z2iecBtYk70=;
        b=wtbODfP8oempy97igHj+wui/TPLCPdTTDqJwAn8hnxHCXvamMmhIYSZJGMNyA08S3+
         9ij/wJqIQwEvPfquftLL/YplBiA+W2iKslxyk9SPdoXE/gNO9r7rWu/Z0siuOWB1ptTI
         L1W6EyWQY2KZti8/LoMapFIHmcTV2Gkmi9M2EJs6izmWIKGKBIchSSUte3FU46OHO0bj
         h0JJKl25O6JuxzNhHHyE2E+0A2HexGq6bOw/87E08ZBFJ9MttSLQsAGUW60P0UbQe8HS
         fLJbQsSqFxCPiryg9qbc88TgJm1GUX9IHX3OXtZlsuqW7x8IJLOBaYT/JYlSSFrLTZ4k
         DZnA==
X-Forwarded-Encrypted: i=1; AJvYcCVBYAoJxLQUNLq/6QXAO37LHetr4YJCTMfh953ZV89GsN6PY78yaoBjzvOwYGz+NuSJ7RScgBLy5zfqGs8x@vger.kernel.org, AJvYcCVeyi0Dx/BzObsuQWSGQxpUyXZlYGFDyS9uiNB+lEWTB2OjiAN7l5PO+vI1J7aoG3q3aahfVflAsTRK@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5U1eo0nLRfdZ6zIr6OFGwUaCA8wzrIeyovZmbLVHfV8aggJG
	UX4//XpqLI1DuaSc+XRgCZSXJBcwBD2Q5dEJ0GvAd9srCKZMxYYe7XHwRqxUav4kee6RLExtGCh
	0wUr1+X99AfxG86GiR7lZBlrlyRM=
X-Gm-Gg: ASbGncvxaMWjq6YlflI0q6mH/KTMwpo5A656zZyIwBLTVJYtDq4xDLZCySvbmi1Jdww
	QUZae6Alne/FZPMRhKlvrjzLact5FDUxS1iJrHg/fK/fEpKeGW4JR8BmSgZFjRa8c4Qp9Oj048t
	AjauTHFcbHJPyPduAiwT/xgNxI93LhxenQ+Nw4G87XHGS/dny2Yez6ebFSDw==
X-Google-Smtp-Source: AGHT+IHaytgVnxl9SA7I949xIwZNqZh7LxfBzNQj2RSHIrZNksgsNrBIHROV6AX9nW50hRdk1JTD/e5B6PYoU2Gd8zA=
X-Received: by 2002:a17:907:d24:b0:abe:ced2:1df3 with SMTP id
 a640c23a62f3a-abf26888dbemr1631454966b.52.1740996664318; Mon, 03 Mar 2025
 02:11:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228094732.54642-1-iansdannapel@gmail.com>
 <20250228094732.54642-3-iansdannapel@gmail.com> <20250228-copilot-trekker-72a20709e9f7@spud>
In-Reply-To: <20250228-copilot-trekker-72a20709e9f7@spud>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Mon, 3 Mar 2025 11:10:53 +0100
X-Gm-Features: AQ5f1JqQClMKHIvCoCt8EaqtM9JwIlMd9cb9Uj2utH3S_uqZoZkYkpXUWjw_f8g
Message-ID: <CAKrir7hdyP-bPKkZOpK3cFp=rvH_MJ98DLKnsRni_BWsQEg5yw@mail.gmail.com>
Subject: Re: [v4 2/3] dt-bindings: fpga: Add Efinix SPI programming bindings
To: Conor Dooley <conor@kernel.org>
Cc: linux-fpga@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, 
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor, thanks for the quick response.

On Fri, Feb 28, 2025 at 7:28=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
> > +description: |
> > +  Efinix FPGAs (Trion, Topaz, and Titanium families) support loading b=
itstreams
> > +  through "SPI Passive Mode".
> > +  Note 1: Only bus width 1x is supported.
> > +  Note 2: Additional pins hogs for bus width configuration must be set
> > +  elsewhere, if necessary.
> > +  Note 3: Topaz and Titanium support is based on documentation but rem=
ains
> > +  untested.
>
> Points 1 and 3 here seem to be driver limitations, and shouldn't really
> be present in a document describing the hardware?
>
Yes, they are driver limitations and probably do not belong here.

> > +properties:
> > +  compatible:
> > +    enum:
> > +      - efinix,trion-spi
> > +      - efinix,titanium-spi
> > +      - efinix,topaz-spi
>
> > +      - efinix,fpga-spi
>
> What hardware does this device represent? Other ones are obvious matches
> to the families you mention, but what is this one?
The proposed compatible is a generic fallback for any Efinix FPGA Series.

Regards
Ian

