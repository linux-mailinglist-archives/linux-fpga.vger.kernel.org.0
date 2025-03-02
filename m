Return-Path: <linux-fpga+bounces-1081-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7098FA4B4BD
	for <lists+linux-fpga@lfdr.de>; Sun,  2 Mar 2025 21:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E9A3AD621
	for <lists+linux-fpga@lfdr.de>; Sun,  2 Mar 2025 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BD31EA7E3;
	Sun,  2 Mar 2025 20:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPfFltjt"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68646169397;
	Sun,  2 Mar 2025 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740948913; cv=none; b=sg/DKEtRLsNn8BDU2CkPCIEZhVRSqhSEmjQNNquga2+0BLXgDJIZWOn/YEa7foyC5zKgh1e5/QrkZ8o2rkp5EQx0gTJMrLy8xtP9BWJlYo3HenHGic26GzzChdS3Wt9m4Vig8136Ky5boK7QRbKui0e7WikDirNeGLcdAdbgvwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740948913; c=relaxed/simple;
	bh=XWliiERbbyy8Bn8E0PLv+IscOFrLx/XXgkzvZBh61Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joNV/kVWEmaMsInqXMmoJGz+cgJsb82H+45QBCyD0MGkbuinekF4VB5UNV1NiWdcZ30N4EiNnIHfsbAYpiLxEm5W3nYHGIFjUIr6P+6EG4yPIL5JQ63lTsRG3upcoQtEXsD4kq6xlr2NDQ7Os/feciD5fMJ6gN39bBs6Znidc1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPfFltjt; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22334203781so74372725ad.0;
        Sun, 02 Mar 2025 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740948912; x=1741553712; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MIsANlbpemSAvYUJATI1txmsltRT9pBM1JA1DBKa+PY=;
        b=JPfFltjtk+Ph38qdoerDglJIJ22a/4t+E9Tcbje97b/bHcaDR1fhRNNIpfcpd5GVKK
         rxjSGC16GEfqDWExTZnydyvcazMBFiDo8c8bC0/hsmAmd88Yqk85PSrE/yDSJtr6k1/m
         3lQ5LfKgGlxN7ozstWAmxHMxMxxjXQ29waPRTw1M45prgvoT0FLchhIDac88Qsvx6FER
         NsR2gnQ6KiPzQWM1kcvUYk7czR7IR+QiA+fsXVfRgtz9S6PTcp0oFwY8Ng4GD7MehH3y
         vBIMcmH3dAEFAjuBM2hOKo6aucDbgB6tWaN+5GJLoZAmKHakkcYZZRcK56CqZFWcdJ3W
         bpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740948912; x=1741553712;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIsANlbpemSAvYUJATI1txmsltRT9pBM1JA1DBKa+PY=;
        b=Rp673uInXrPoG7MlnA8ZiHksebg52CjZANrKsLmEv/49NrW5Fv7HwooARLkzmRpxil
         NtS7xRJEDmmlHtZn+mHFhrOOhFzU0FmikFTRfilYo61yZqwEIx53Az918xs4z9NTGMM0
         CXaUYFl2tlY5ZsKGl1bp+sGfpb3TnhiiUeitaFv+igpRA+0TV9XyZR9cHPVaoVQe/7o+
         DRr7mubym6oF0FOQ6i0d2XI3xnNzNJMQXHUym1AnCABRFRK3tKVxa3GHWXZ++dwllo3O
         E0xyo7G3+QIkaXKKTe42aHcCSOLBnKT3d78SD+VXKZ19HiMqo/RZ9EvbaWxZc8o3ssQ+
         UWgw==
X-Forwarded-Encrypted: i=1; AJvYcCUNN25LHUdzpZTHDpLOnMmoYFZ9L4jVcyXs7fvPJ4jfhMloyeVdphqL7z5vZ8DGP0XAD7ioidd4P5QLdK+N@vger.kernel.org, AJvYcCVEq5r1jEZEzBcGkTAxkSeskra9tIZvwkbUSlZ5fDA1Pg8OukxtDl4Z8r2jVPgItGZR6yyvV/4y@vger.kernel.org, AJvYcCXsK740zS6DTYUUdadrUItktXwwMS05rSlnNW6CZpBDBmekOwTG0nbF1omhWIy5OSdG2LbJZ/fQMO5V@vger.kernel.org
X-Gm-Message-State: AOJu0YwM1CpdN8Hl6NTaAXeTn0e7BRsqMjwX/ZYNTIhPW5q/EVJojCtq
	nD138PIm2b+FPTqWtfh8WrHI9/iHHqu1M6uEQ/Us/ceLFjUyLvn/
X-Gm-Gg: ASbGncs2Y8zdsJylg0QZ6jvz3Ui3AIoa0ujTZI/kUIAxTIOTEwzW2j5dROPyzW1+ljj
	V+Wcs9/m+3DY5s2xZG3Oz3vSEZGa7uAiy4z2akGyG4mzcALjkhnVS9EiyydTCPDxHIiF5NUOrmU
	SIW7Y7XiINJP8iDCxBdYDbkOk9jAY5dXLP4sOpl1khSX1YjE/JJ+5QvLigN3i2/l4FO17xajsqL
	lsj43pxup0FN+111drC7+NEZYjxwMEUvupns+Cr2sLhs7ooYrOCEYvt3DmLFVo3HKHBH/vPy3rC
	UoyOjMt59rKZ8Az6SuPQFzYk3Mqauk5IUHpHk6azutnupogx1WdQgmdwQt8W3FrG
X-Google-Smtp-Source: AGHT+IH8H2yZhQg9G95kh4tg6980t5/bY9s3kFnyXMrNWDbrZpJnUQOLGgkQpAxZPwXXpcTbBSwCgA==
X-Received: by 2002:a05:6a21:730e:b0:1f3:20be:c18a with SMTP id adf61e73a8af0-1f320bec3demr3511925637.10.1740948911651;
        Sun, 02 Mar 2025 12:55:11 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7dec49fcsm6812512a12.50.2025.03.02.12.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 12:55:10 -0800 (PST)
Date: Sun, 2 Mar 2025 12:55:08 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tianfei Zhang <tianfei.zhang@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Calvin Owens <calvin@wbinvd.org>,
	Philipp Stanner <pstanner@redhat.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fpga@vger.kernel.org
Subject: Re: [PATCH] RFC: ptp: add comment about register access race
Message-ID: <Z8TFrPv1oajA3H4V@hoboy.vegasvil.org>
References: <20250227141749.3767032-1-arnd@kernel.org>
 <Z8CDhIN5vhcSm1ge@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z8CDhIN5vhcSm1ge@smile.fi.intel.com>

On Thu, Feb 27, 2025 at 05:23:48PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 27, 2025 at 03:17:27PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > While reviewing a patch to the ioread64_hi_lo() helpers, I noticed
> > that there are several PTP drivers that use multiple register reads
> > to access a 64-bit hardware register in a racy way.
> > 
> > There are usually safe ways of doing this, but at least these four
> > drivers do that.  A third register read obviously makes the hardware
> > access 50% slower. If the low word counds nanoseconds and a single
> > register read takes on the order of 1µs, the resulting value is
> > wrong in one of 4 million cases, which is pretty rare but common
> > enough that it would be observed in practice.

If the hardware does NOT latch the registers together, then the driver must do:

  1. hi1 = read hi
  2. low = read lo
  3. hi2 = read h1
  4. if (hi2 == hi1 return (hi1 << 32) | low;
  5. goto step 1.

This for correctness, and correctness > performance.

> > Sorry I hadn't sent this out as a proper patch so far. Any ideas
> > what we should do here?

Need to have driver authors check the data sheet because ...

> Actually this reminds me one of the discussion where it was some interesting
> HW design that latches the value on the first read of _low_ part (IIRC), but
> I might be mistaken with the details.
> 
> That said, it's from HW to HW, it might be race-less in some cases.

... of this.

Thanks,
Richard

