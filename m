Return-Path: <linux-fpga+bounces-1099-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82100A4EC5E
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Mar 2025 19:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E412718863B8
	for <lists+linux-fpga@lfdr.de>; Tue,  4 Mar 2025 18:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2642E3368;
	Tue,  4 Mar 2025 18:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J1HPdinK"
X-Original-To: linux-fpga@vger.kernel.org
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297A72E337A
	for <linux-fpga@vger.kernel.org>; Tue,  4 Mar 2025 18:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741113808; cv=fail; b=BkoZMjCn3r50Udtxxj7IBskFrXaZYS3Z5Rbmn5F7aSD+xikoBf9SJppgwdMU6dw3ZKSKvoRx74JlNgJAKqzmjYydy8GsyzCDTeb/reHXDlu5UOKuF4xgJI1iumnvTJQfM7UcmSw9McatkxQNjHc+0GZ3b3r1oxMwb6htI1yIZxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741113808; c=relaxed/simple;
	bh=MRsuqGKDkpM+V3F9xTGFLKoSRBfvbpgCRGM3wSNsO4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpEBR7DGks7wAYoI8xfpieBTDe0blvB9cRxom6d1usNYJhd2GavlINRe+EhBZ+XUIeououQIrcZYbL6C6WumicNouOfhsxhXtn/+7lDW0TTES2/rDzf5EcGzjb5zfGX8eBiO/6KTrlO6pUJJmr6q1Ayg2XK2XjR0oyv1VcNMxec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1HPdinK reason="signature verification failed"; arc=none smtp.client-ip=192.198.163.15; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; arc=fail smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 5948440D0500
	for <linux-fpga@vger.kernel.org>; Tue,  4 Mar 2025 21:43:25 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dS95ClZzFww0
	for <linux-fpga@vger.kernel.org>; Tue,  4 Mar 2025 17:32:25 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 1E4A94272D; Tue,  4 Mar 2025 17:32:20 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1HPdinK
X-Envelope-From: <linux-kernel+bounces-541107-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1HPdinK
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 1BCA441CBE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:50:41 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id E6EFF2DCE5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:50:40 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7197B1892085
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 07:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8161EEA49;
	Mon,  3 Mar 2025 07:50:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA561EE03D;
	Mon,  3 Mar 2025 07:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740988211; cv=none; b=IQCPhjwz0kTcfBvoFS1hpOpl5Whi8VJo4kgLfEhmsT7MnpDbs7GNkATOI2l9r0e4zvXmbJXXDARu2L0ynFb8YVyBrU7InhDMb0r6HelWHAU4qz3im0J/wAADYGzJu9uWe9cueNGaWd9/JB+8CPpG8tL3qeAPZ65qHF7g+BwWJ0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740988211; c=relaxed/simple;
	bh=4aoAkVkWJ9rE1k/obWZXGikyJB41caL0MMe9Y2MIi4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBtNB85Sw4WHQCCFloQtUBFZwUduLThz4/f8j2OGTLnprvV1lfZZYPYrBWyfOdlmhdAnKoe//R0Nh0uJJY9/XtFdDzhyWrXPl+MaoN7V8yaoFc+xPt6ZgNJKxmmJNpvwdeLxST/Z2FPAiZILqmzhCt7VsulGKldayMrST91EcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J1HPdinK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740988210; x=1772524210;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4aoAkVkWJ9rE1k/obWZXGikyJB41caL0MMe9Y2MIi4Q=;
  b=J1HPdinK/KHhwgQv/bWmTAhKcU/J6BvYcJoHelipf0r3WU49WMITlKHJ
   FdWx1Vxm27zOYt8/7WFW3kE35CIjvAx/f2TYK5uGFBebI2Ow/Vbr38YFe
   IgQy6sSqVYqGbQru/lInxN2PdqscsrlonqOAo39mepYr8FlliEhxkbmaO
   G3lmxGw5CAebtk0fv8mfzGI+58cgvvVWLKH4eoIr6YEONXbq2zMHiODfN
   m0sfKih4ovJSMndfK9ORG1aj5XISwMWeBmgNrVlU5JsFyQVE2E6eWDs6f
   aczZIFCgYj7i0UUS+jEsPwjOnaGGSmaw0ETEI2DwuITULXkaAM/w2eaTv
   Q==;
X-CSE-ConnectionGUID: AXQRHB34QcOtqvi2QUpwsQ==
X-CSE-MsgGUID: FAG3B9gWRW6NFITqEzXHLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11361"; a="41974308"
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="41974308"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 23:50:09 -0800
X-CSE-ConnectionGUID: r4EkK5uLTOOHRZNDHcCvsQ==
X-CSE-MsgGUID: oK5Me+PZRnKJQDwsK0W+pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,329,1732608000"; 
   d="scan'208";a="117733442"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2025 23:50:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tp0Yr-0000000GkI5-1VwS;
	Mon, 03 Mar 2025 09:50:01 +0200
Date: Mon, 3 Mar 2025 09:50:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Richard Cochran <richardcochran@gmail.com>
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
Message-ID: <Z8VfKYMGEKhvluJV@smile.fi.intel.com>
References: <20250227141749.3767032-1-arnd@kernel.org>
 <Z8CDhIN5vhcSm1ge@smile.fi.intel.com>
 <Z8TFrPv1oajA3H4V@hoboy.vegasvil.org>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <Z8TFrPv1oajA3H4V@hoboy.vegasvil.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dS95ClZzFww0
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741714155.92947@TuFS2Q21DgzuvaXaS9e6Og
X-ITU-MailScanner-SpamCheck: not spam

On Sun, Mar 02, 2025 at 12:55:08PM -0800, Richard Cochran wrote:
> On Thu, Feb 27, 2025 at 05:23:48PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 27, 2025 at 03:17:27PM +0100, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >=20
> > > While reviewing a patch to the ioread64_hi_lo() helpers, I noticed
> > > that there are several PTP drivers that use multiple register reads
> > > to access a 64-bit hardware register in a racy way.
> > >=20
> > > There are usually safe ways of doing this, but at least these four
> > > drivers do that.  A third register read obviously makes the hardwar=
e
> > > access 50% slower. If the low word counds nanoseconds and a single
> > > register read takes on the order of 1=B5s, the resulting value is
> > > wrong in one of 4 million cases, which is pretty rare but common
> > > enough that it would be observed in practice.
>=20
> If the hardware does NOT latch the registers together, then the driver =
must do:
>=20
>   1. hi1 =3D read hi
>   2. low =3D read lo
>   3. hi2 =3D read h1
>   4. if (hi2 =3D=3D hi1 return (hi1 << 32) | low;
>   5. goto step 1.
>=20
> This for correctness, and correctness > performance.

Right.

> > > Sorry I hadn't sent this out as a proper patch so far. Any ideas
> > > what we should do here?
>=20
> Need to have driver authors check the data sheet because ...
>=20
> > Actually this reminds me one of the discussion where it was some inte=
resting
> > HW design that latches the value on the first read of _low_ part (IIR=
C), but
> > I might be mistaken with the details.
> >=20
> > That said, it's from HW to HW, it might be race-less in some cases.
>=20
> ... of this.

Perhaps it's still good to have a comment, but rephrase it that the code =
is
questionable depending on the HW behaviour that needs to be checked.

--=20
With Best Regards,
Andy Shevchenko




