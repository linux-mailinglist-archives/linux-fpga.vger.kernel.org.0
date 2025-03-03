Return-Path: <linux-fpga+bounces-1091-lists+linux-fpga=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEA2A4C010
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 13:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 312A63A7BF0
	for <lists+linux-fpga@lfdr.de>; Mon,  3 Mar 2025 12:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9433203703;
	Mon,  3 Mar 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4we2YJ8"
X-Original-To: linux-fpga@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4905C1E98E0;
	Mon,  3 Mar 2025 12:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004219; cv=none; b=aXBOfUYtpW730HgXV97F0ET0LGbPhiZnq/KuarwjrwmwFLpU34VwXmyjQCwUsRZLu/niATOJEKYmOPcVjBEy9DHH8WRTv5IY77C/cUmlW86/Psx5wbKzUAsKAxZXg8sVPGFsgtQhWP3pFRwhtR1okkeEAq5rtGeOnygt6+275mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004219; c=relaxed/simple;
	bh=dmWAA5A6KdZDZ5q6P5+UJ63tpLhJK4oP5t2qo+k2F0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A7BHONeMlgfoRTavlgSUPnqpktSixSfSqp3DgVRkFJycHmY7ZXmpysXlTAbY1Wq3mwnNqUy+YsafU35bPY7yJbg3Nue5zsOgvYaZgOaWD/dLdYdXnOjflfojoSiyP5DOSkZ0v9LO8Ww8kd39emJQ5qEqjGGOUD34vTzuUifLO6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4we2YJ8; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac0cc83e9adso133241466b.0;
        Mon, 03 Mar 2025 04:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741004216; x=1741609016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmWAA5A6KdZDZ5q6P5+UJ63tpLhJK4oP5t2qo+k2F0c=;
        b=m4we2YJ8Bxxenvp4BVM0dakxRhLiGfYv/UOCZdadEeggZEVZ4pxAnSWao6i2PG46ya
         vt7f5kxAlq6rLNd8cSHzWR3Jp+C9HmD5CakO1NsSidkS6Pw8q5+9+pWS/2QwNHABJPn+
         fMOcRleUHCg1DlxiFuP+C1Q8GAZJJqtzhrUXJYN6Z0204a5X1ay/jjOcEF2txIi4WkG8
         faDJKw9CzsO4UWQhSYQqxZGs4+YGqJ2esN2F6ZWciDdVA7jgF9Y2kShEQ+UheEYPBOgE
         6hTCCwKbdcrx5YWCZ+PY2nFPcc+BxsWJBQaBdcmJF5Mgk6OSEwqbAKQ23Co6TcUn3cC8
         +14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741004216; x=1741609016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmWAA5A6KdZDZ5q6P5+UJ63tpLhJK4oP5t2qo+k2F0c=;
        b=WzrKini5nywGL10xR0GZNfwtHUMHpthbmWuNUq83X3y6ixVI6QBsq+czBbSmJpuC+r
         eZS2XNGB4O8nnLHZHF1112WuT2WNccAyI1BulI9VdKFOZb5lKARmE+N4Qbu1FD0rdOty
         yX/qLf0d4KloNWzj9AbWtBjEMHhqYYkVatJJAsGD99a0ZAfstfGCtX0PaUPQuDoRr4ed
         BrFINf5KMlBkiSyn3tjKtuKK+VNw1gHc8/LKftF0ESEFU7ejqTqqu6ID7lmcXpygErJE
         fpIzqZMsPvR+NPuL8Q4Z8WMMp5vp9u8bxvpyRIzOE8Vo4L/aaCEM7cRKMFG2W6lAK/Rm
         LVmw==
X-Forwarded-Encrypted: i=1; AJvYcCUNpW6Oiy+Uzc3d7zIgTO1swH+pshVjiJ/2hlniqLjaqN8a/N/AX/cKK5fmL8vpk++T6RhOLS7mLWab@vger.kernel.org, AJvYcCUrM9PXtIz33sLwyNIm1ricnxbqMSnjCLiUFMWOXjfJHMv2ISY7Q7wSiGm3/QlYO7P4ej8XRsO32juTccYR@vger.kernel.org
X-Gm-Message-State: AOJu0YxMNdP4E97CD2JyZDBAYRZ/SkFA9kY2OZrmkwA03YCCanYDCA2m
	sgU+p3Hr3rZMbt/TA2Wq66Lz90TsQQIL37uewD6pANORcX91z8G/sujeHmZCA46W/P7EQKKQgDS
	AKSCipodkJlpBFXDoXGyk2uDZshI=
X-Gm-Gg: ASbGncs2ZpW4oEQT0eLGW7ZMtOleRaDFu0QGmZRhC4k8v6eFWVRebWfainHBs5ZARR/
	FPrfP52wWb/NA9gYWH7HZDbp+99Fr890AeyNFbNhGSKJ85yivLHsDwadNcEQVNGpat2Hn+D6MWB
	TfM8tnxzWVsr3HXdX7hADkkfoKKHHFzqh9ukp/T1bclpfGaDkbHpBRoabhYA==
X-Google-Smtp-Source: AGHT+IEWsg75v/hQusO92wYbok77xTnTZBB5fIXFZNML07kPJN+1v9SRSHAjW0zlT+EHg8Qt0iPZnwIWSqsWtbaE2Es=
X-Received: by 2002:a17:906:9993:b0:abf:52e1:2617 with SMTP id
 a640c23a62f3a-abf52e13b44mr681831766b.25.1741004216262; Mon, 03 Mar 2025
 04:16:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fpga@vger.kernel.org
List-Id: <linux-fpga.vger.kernel.org>
List-Subscribe: <mailto:linux-fpga+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fpga+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228094732.54642-1-iansdannapel@gmail.com>
 <20250228094732.54642-4-iansdannapel@gmail.com> <DS7PR12MB607055136A599EE9A1895414CDC92@DS7PR12MB6070.namprd12.prod.outlook.com>
In-Reply-To: <DS7PR12MB607055136A599EE9A1895414CDC92@DS7PR12MB6070.namprd12.prod.outlook.com>
From: Ian Dannapel <iansdannapel@gmail.com>
Date: Mon, 3 Mar 2025 13:16:45 +0100
X-Gm-Features: AQ5f1JqygE9vrhI-0VSmBZEWXAxe5mQktxDfRVX1U01SZtvfEewck3e2d6EJxis
Message-ID: <CAKrir7iKLw6QUgywW1BM7JF2WK7m_fBEoOt1h7DS-+i7qH2ZKA@mail.gmail.com>
Subject: Re: [v4 3/3] fpga-mgr: Add Efinix SPI programming driver
To: "Manne, Nava kishore" <nava.kishore.manne@amd.com>
Cc: "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>, Moritz Fischer <mdf@kernel.org>, 
	Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Aradhya Bhatia <a-bhatia1@ti.com>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Navakishore, thanks for the review.

On Mon, Mar 3, 2025 at 12:57=E2=80=AFPM Manne, Nava kishore
<nava.kishore.manne@amd.com> wrote:

> > +MODULE_DESCRIPTION("Efinix FPGA SPI Programming Driver (Topaz/Titanium
> > +untested)");
>
> If untested, it might be useful to mark them as experimental in Kconfig.
Is a separate Kconfig for that preferred or maybe just a note in the
help description?

Regards, Ian

