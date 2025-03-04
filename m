Return-Path: <linux-fpga+bounces-1093-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE80A4D25D
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Mar 2025 05:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B103ADF96
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Mar 2025 04:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05211F461E;
	Tue,  4 Mar 2025 04:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMv3FZAs"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B691F419F;
	Tue,  4 Mar 2025 04:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741061363; cv=none; b=rN6opfk7uTzzPTv5gulWtdwuoGEctTBMdu3qbEhhMPZH90jS7W67BzKpqes+FahkC6hepkf+gqWe1n2AEP2+yZxwNKtsRJOi8RwkQ7ky8fKZvX3cQ0lcC8DPMH6B70OuKfiusacjIj0RtGocEtFSnObbiGFlhbAcYW8txqaO3wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741061363; c=relaxed/simple;
	bh=QtGZ+48M+A4XErPJpnzcWrfq+nhpsQ5M6eGsMDSJ7Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oJ/hS/MOLvxEqB4opKWh4oJm6kfNtM6E46R3bYPwIlEZ71V4aD6W33VH+tCHPAE/NFCiE1I+CcxwsHytG3uxUyttjtrGoLmr5GrvaWkJK8UE4I6Al9ucDGVKBK2EiozTeQj58I6o40Hb7Sspw2fy32AMyyzz3fm9qOh10KXh2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMv3FZAs; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2f9b91dff71so8280267a91.2;
        Mon, 03 Mar 2025 20:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741061361; x=1741666161; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QtGZ+48M+A4XErPJpnzcWrfq+nhpsQ5M6eGsMDSJ7Zc=;
        b=mMv3FZAszzKro/THwO9JI093IFc0WtlDMrxXIy5zRoud7b3l/lCisKnQQQaalLSqeK
         3MZuwuJ7PHpubibCuQaBTFwKt8S1OHCmjA6y48p/sZ/eQM38ip5sHmty5yLf9+I97tdd
         Dy1Tu1aMwA5MP4FpvSb2zvhL+UwN3y1j9HNNkCitwE+T7NLGXxXweP2GBWhVrobfwqjV
         EO6HoLT5MDBsfxvB3eVo74ImWUMHBogvTmAFa6qdAm2h52U7ZhzVmNZwRj6UxLLzKXGa
         SSwE9FRfo75P54Qe+auXqj7k5ybR5QrKEOvDnx8XCCAk1UQJDPALAU4b19zCWPfsTs2L
         CVMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741061361; x=1741666161;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtGZ+48M+A4XErPJpnzcWrfq+nhpsQ5M6eGsMDSJ7Zc=;
        b=KZlzAKPthDbPqVLjPVN+hIaRqz67+8YrhAr2yoHvSl7JKPwlNj55CXMFVTm04LVaAx
         wJXg99+PXCVGD/PJTHSGvwztcvnUepRagIUQJpnaq9IyMtYskz4IfD1gtvy3VwYQSRNc
         kj/Jehts4ceL+cwChVwyEzFiKfgeEmS9KySawZixkatGaglx0Wioxyu1oLpqyqQmlgGo
         gEg3qPbGYtkz0AhIVUvlpeVgy8nWbAlrueVvIGpXX6uoprwqjzn6im7bRcAoWIB1F34E
         NVzX6KSziOUrXOIf7tbxqlVlaZtA0WzyXGlO4NnvP+zHqFGmG+/ROq7mIkg6/OAj2HmS
         m2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUHEYPNA+QbpmcdhayZoHpkIeCGKBYM/eMMWWhgzyRkY1yLm8LJqPvp4W3FBcb0YXp3YVFvK/cP@vger.kernel.org, AJvYcCW3ErhQJt4hQtFQ//uc5B+JqKOQRfMQuh6HRU6zYYd0DNHHDupnG6NmiOzmEkSzpxwKTsh5hFnjlIsitzgx@vger.kernel.org, AJvYcCXIsyCXc3glLLJcIEO8mVV1q15pkKbwwETiHDO1uqZWDxiNfbo+Aegsv4Qj5WVF66nXLADm5smtdXNJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFX8ol8KjnrWQIbeqB985uwNi9xJ2eeuiygAg8L3mmhbA9YqP
	ACYwkszerwBNsx9PLw0+o6tbRvXrHuWEQLt7FXh1IxGhONqJ1uWa
X-Gm-Gg: ASbGncvgxYu+aAZG9rLJAHGD8J22ibYTFxIzR0SU/ro+dIDx7CHia8Efnq9n/k4sqa4
	XLkxWX67DRydeOhxilIh8eHyu5j07GSW42H8Z6CPxDFSW5XpRMIRTftdvup2Hiq20aW1D95PeNy
	8/Bw94uYw6qNKCaXlV1tipn0SS1GLAnoknYW/0LJgsnW79nhEYLqzX8LnHfhE+aRIAozkm2r+ES
	vFKwjkV1cF71oZwxJ6+iYydz4vMQBJPFU0nE87WersdnRC7YmSXauOi2tG2xqmBculf2Wj7iUEH
	bQyo2T0wwPY1mqi4e53zwhFZ9RY6L84ztIKjSBPQUJylt06m1s3FcPcGJ+Pu4M4u
X-Google-Smtp-Source: AGHT+IE0xGWFuyaKz7xSNaqOF/UjIyP6Qm5Nry/Rj8pFeBQSgkdnwjA1FkIkdqwXGWdukbrbMn4twA==
X-Received: by 2002:a17:90b:4ac6:b0:2ee:fdf3:38dd with SMTP id 98e67ed59e1d1-2febabf413amr18352992a91.23.1741061361374;
        Mon, 03 Mar 2025 20:09:21 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9e1asm85724885ad.65.2025.03.03.20.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 20:09:20 -0800 (PST)
Date: Mon, 3 Mar 2025 20:09:18 -0800
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
Message-ID: <Z8Z87mkuRqE6VOTy@hoboy.vegasvil.org>
References: <20250227141749.3767032-1-arnd@kernel.org>
 <Z8CDhIN5vhcSm1ge@smile.fi.intel.com>
 <Z8TFrPv1oajA3H4V@hoboy.vegasvil.org>
 <Z8VfKYMGEKhvluJV@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8VfKYMGEKhvluJV@smile.fi.intel.com>

On Mon, Mar 03, 2025 at 09:50:01AM +0200, Andy Shevchenko wrote:
> Perhaps it's still good to have a comment, but rephrase it that the code is
> questionable depending on the HW behaviour that needs to be checked.

IIRC both ixp4xx and the PCH are the same design and latch high reg on
read of low.

Thanks,
Richard

